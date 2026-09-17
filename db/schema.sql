-- Apna Aspatal — core database schema for Supabase (Postgres + PostGIS)
-- Run this in the Supabase SQL Editor. Safe to run once on a fresh project.
--
-- Design principle: every table a hospital's own staff should be able to
-- edit later (doctors, treatments, beds) is separate and keyed by
-- hospital_id — this mirrors the "filled by hospitals" architecture we
-- planned for the app's hospital-detail screen.

create extension if not exists postgis;

-- ============================================================
-- PROFILES — one row per auth.users, carries the app-level role
-- ============================================================
create type user_role as enum ('patient', 'hospital_staff', 'driver', 'admin');

create table profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  role user_role not null default 'patient',
  hospital_id uuid,              -- set when role = 'hospital_staff'
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Auto-create a profile row whenever someone signs up (phone OTP or any
-- other method) — this is the standard Supabase pattern.
create or replace function handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, full_name)
  values (new.id, new.raw_user_meta_data->>'full_name');
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function handle_new_user();

-- ============================================================
-- HOSPITALS
-- ============================================================
create type hospital_type as enum ('government', 'private', 'multi_specialty', 'clinic');
create type verification_status as enum ('pending', 'approved', 'rejected', 'suspended');

create table hospitals (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  registration_number text,               -- govt hospital license/registration id
  hospital_type hospital_type not null default 'private',
  verification_status verification_status not null default 'pending',

  address text,
  city text,
  state text,
  pincode text,
  location geography(point, 4326),        -- for "nearest hospital" queries

  reception_phone text,
  emergency_phone text,
  email text,

  accepted_payment_modes text[] default '{}',   -- e.g. {cash, insurance, cashless}
  has_blood_bank boolean default false,
  photo_url text,

  created_by uuid references profiles(id),      -- the hospital-staff account that registered it
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table profiles
  add constraint fk_profiles_hospital foreign key (hospital_id) references hospitals(id);

create index hospitals_location_idx on hospitals using gist (location);

-- ============================================================
-- DOCTORS
-- ============================================================
create table doctors (
  id uuid primary key default gen_random_uuid(),
  hospital_id uuid not null references hospitals(id) on delete cascade,
  name text not null,
  specialty text not null,
  qualification text,
  experience_years int,
  consultation_fee numeric(10,2),
  available_days text[] default '{}',      -- e.g. {Mon,Wed,Fri}
  available_time_from time,
  available_time_to time,
  photo_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index doctors_hospital_idx on doctors(hospital_id);

-- ============================================================
-- TREATMENT / PROCEDURE CHARGES
-- ============================================================
create table treatment_charges (
  id uuid primary key default gen_random_uuid(),
  hospital_id uuid not null references hospitals(id) on delete cascade,
  name text not null,                      -- e.g. "Appendix surgery"
  category text,                           -- e.g. "surgery", "diagnostic"
  cost_from numeric(10,2) not null,
  cost_to numeric(10,2) not null,
  updated_at timestamptz not null default now()
);

create index treatments_hospital_idx on treatment_charges(hospital_id);

-- ============================================================
-- BED CATEGORIES (general / private / icu / icu_ventilator / pediatric / maternity)
-- ============================================================
create type bed_type as enum ('general', 'private', 'icu', 'icu_ventilator', 'pediatric', 'maternity');

create table bed_categories (
  id uuid primary key default gen_random_uuid(),
  hospital_id uuid not null references hospitals(id) on delete cascade,
  type bed_type not null,
  label text not null,
  total_count int not null default 0,
  available_count int not null default 0,
  cost_per_day numeric(10,2) not null,
  updated_at timestamptz not null default now(),
  unique (hospital_id, type)
);

create index beds_hospital_idx on bed_categories(hospital_id);

-- ============================================================
-- AMBULANCES / DRIVERS
-- ============================================================
create table ambulances (
  id uuid primary key default gen_random_uuid(),
  hospital_id uuid references hospitals(id),   -- nullable: independent operators allowed
  driver_id uuid references profiles(id),
  vehicle_number text not null,
  status text not null default 'offline',      -- available | on_trip | offline
  created_at timestamptz not null default now()
);

-- ============================================================
-- EMERGENCY REQUESTS — the core dispatch record
-- ============================================================
create type request_status as enum (
  'draft', 'queued', 'sent', 'verifying', 'dispatched', 'arrived', 'failed'
);

create table emergency_requests (
  id uuid primary key default gen_random_uuid(),
  client_request_id text unique not null,     -- generated on-device; makes retries idempotent
  patient_id uuid references profiles(id),    -- nullable: anonymous SOS is allowed
  location geography(point, 4326),
  status request_status not null default 'sent',
  verification_mode text,                     -- video | audio | unavailable
  hospital_id uuid references hospitals(id),
  ambulance_id uuid references ambulances(id),
  eta_minutes int,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index requests_hospital_idx on emergency_requests(hospital_id);
create index requests_patient_idx on emergency_requests(patient_id);

-- ============================================================
-- ROW LEVEL SECURITY
-- ============================================================
alter table profiles enable row level security;
alter table hospitals enable row level security;
alter table doctors enable row level security;
alter table treatment_charges enable row level security;
alter table bed_categories enable row level security;
alter table emergency_requests enable row level security;

-- profiles: users manage their own row
create policy "read own profile" on profiles for select using (auth.uid() = id);
create policy "update own profile" on profiles for update using (auth.uid() = id);

-- hospitals: anyone can read approved hospitals; staff edit their own; nobody
-- self-approves (approval is done via the Node backend's service-role key)
create policy "public reads approved hospitals" on hospitals
  for select using (verification_status = 'approved');

create policy "staff reads own hospital regardless of status" on hospitals
  for select using (
    exists (select 1 from profiles where profiles.id = auth.uid() and profiles.hospital_id = hospitals.id)
  );

create policy "staff updates own hospital" on hospitals
  for update using (
    exists (select 1 from profiles where profiles.id = auth.uid() and profiles.hospital_id = hospitals.id)
  );

-- doctors / treatments / beds: public read, hospital-staff write for their own hospital
create policy "public reads doctors" on doctors for select using (true);
create policy "staff manages own doctors" on doctors for all using (
  exists (select 1 from profiles where profiles.id = auth.uid() and profiles.hospital_id = doctors.hospital_id)
);

create policy "public reads treatments" on treatment_charges for select using (true);
create policy "staff manages own treatments" on treatment_charges for all using (
  exists (select 1 from profiles where profiles.id = auth.uid() and profiles.hospital_id = treatment_charges.hospital_id)
);

create policy "public reads beds" on bed_categories for select using (true);
create policy "staff manages own beds" on bed_categories for all using (
  exists (select 1 from profiles where profiles.id = auth.uid() and profiles.hospital_id = bed_categories.hospital_id)
);

-- emergency_requests: patient sees their own; hospital staff see requests
-- routed to their hospital
create policy "patient reads own requests" on emergency_requests
  for select using (auth.uid() = patient_id);

create policy "hospital staff reads routed requests" on emergency_requests
  for select using (
    exists (select 1 from profiles where profiles.id = auth.uid() and profiles.hospital_id = emergency_requests.hospital_id)
  );
