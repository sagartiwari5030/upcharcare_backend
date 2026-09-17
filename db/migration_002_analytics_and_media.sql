-- Migration 002 — patient-interest analytics + storage bucket for
-- hospital logos and doctor photos. Run this in the Supabase SQL Editor
-- AFTER schema.sql. Safe to run once.

-- ============================================================
-- INTEREST EVENTS — logged when a patient views a doctor or treatment
-- in the patient app. This is forward-looking: the RN patient app
-- doesn't call this yet (it still uses mock data), so counts will show
-- zero until that wiring happens. The infrastructure is ready either way.
-- ============================================================
create table interest_events (
  id uuid primary key default gen_random_uuid(),
  hospital_id uuid not null references hospitals(id) on delete cascade,
  doctor_id uuid references doctors(id) on delete cascade,
  treatment_id uuid references treatment_charges(id) on delete cascade,
  kind text not null check (kind in ('doctor', 'treatment')),
  created_at timestamptz not null default now(),
  constraint one_target_only check (
    (kind = 'doctor' and doctor_id is not null and treatment_id is null) or
    (kind = 'treatment' and treatment_id is not null and doctor_id is null)
  )
);

create index interest_events_hospital_idx on interest_events(hospital_id);
create index interest_events_doctor_idx on interest_events(doctor_id);
create index interest_events_treatment_idx on interest_events(treatment_id);

alter table interest_events enable row level security;

-- Anyone (including anonymous patients) can log an interest event —
-- this is a write-only, non-sensitive action from the patient app's side.
create policy "anyone can log interest" on interest_events
  for insert with check (true);

-- Only that hospital's own staff (or admin) can read their analytics.
create policy "staff reads own hospital analytics" on interest_events
  for select using (
    exists (select 1 from profiles where profiles.id = auth.uid() and profiles.hospital_id = interest_events.hospital_id)
  );

-- ============================================================
-- STORAGE — a public bucket for hospital logos and doctor photos.
-- Files are stored under a path like: <hospital_id>/logo.jpg or
-- <hospital_id>/doctors/<doctor_id>.jpg — folder-scoped RLS below
-- enforces that a hospital can only write inside its own folder.
-- ============================================================
insert into storage.buckets (id, name, public)
values ('hospital-media', 'hospital-media', true)
on conflict (id) do nothing;

create policy "public reads hospital media"
  on storage.objects for select
  using (bucket_id = 'hospital-media');

create policy "staff uploads to own hospital folder"
  on storage.objects for insert
  with check (
    bucket_id = 'hospital-media'
    and exists (
      select 1 from profiles
      where profiles.id = auth.uid()
      and profiles.hospital_id::text = (storage.foldername(name))[1]
    )
  );

create policy "staff updates own hospital folder"
  on storage.objects for update
  using (
    bucket_id = 'hospital-media'
    and exists (
      select 1 from profiles
      where profiles.id = auth.uid()
      and profiles.hospital_id::text = (storage.foldername(name))[1]
    )
  );
