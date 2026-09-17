-- Migration 003 — real geospatial "nearby hospitals" search.
-- Run in the Supabase SQL Editor AFTER migration_002.

-- A Postgres function (called via supabaseAdmin.rpc) that finds
-- approved hospitals within a radius, sorted nearest-first, using
-- PostGIS. Also returns a rough available-bed count per hospital so
-- the patient app's nearby list can show something useful without a
-- second query per hospital.
create or replace function nearby_hospitals(lat double precision, lng double precision, radius_km double precision default 25)
returns table (
  id uuid,
  name text,
  hospital_type hospital_type,
  city text,
  emergency_phone text,
  distance_km double precision,
  beds_available bigint
)
language sql stable
as $$
  select
    h.id,
    h.name,
    h.hospital_type,
    h.city,
    h.emergency_phone,
    ST_Distance(h.location, ST_SetSRID(ST_MakePoint(lng, lat), 4326)::geography) / 1000 as distance_km,
    coalesce((select sum(b.available_count) from bed_categories b where b.hospital_id = h.id), 0) as beds_available
  from hospitals h
  where h.verification_status = 'approved'
    and h.location is not null
    and ST_DWithin(h.location, ST_SetSRID(ST_MakePoint(lng, lat), 4326)::geography, radius_km * 1000)
  order by distance_km asc;
$$;
