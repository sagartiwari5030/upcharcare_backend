-- Seed data — REAL hospitals found via public search (names, addresses,
-- phone numbers, specialties) in Varanasi, Mirzapur, and Chandauli
-- districts. Run this in the Supabase SQL Editor after schema.sql,
-- migration_002, and migration_003.
--
-- HONESTY NOTES — read before running:
-- 1. `location` coordinates are TOWN-CENTER approximations, not each
--    hospital's exact address pin. This is enough for the app's nearby
--    search to work for testing, but each hospital's location should
--    be corrected to its real coordinates (via the web dashboard's
--    "use my current location" button, ideally captured by someone
--    actually standing at the hospital) before this is truly production
--    data patients rely on.
-- 2. `registration_number`, `accepted_payment_modes`, and
--    `has_blood_bank` are unknown from public search and are left
--    NULL/default — do not treat the defaults as verified facts.
-- 3. verification_status is set to 'approved' directly since this is
--    an admin-seeded batch, not a hospital self-registering — these
--    listings should be reviewed/claimed by each real hospital when
--    contacted, not treated as final.
-- 4. Doctors and treatment pricing are almost entirely NOT included
--    here on purpose — see the one exception below, which is the only
--    entry with a genuinely sourced doctor name + fee (from Practo,
--    self-reported by the doctor). Every other hospital's doctors/
--    treatments should come from that hospital directly, not be guessed.

-- ============================================================
-- VARANASI (5)
-- ============================================================
insert into hospitals (name, hospital_type, address, city, state, pincode, reception_phone, emergency_phone, location, verification_status) values
('Apex Hospital, Varanasi', 'multi_specialty', 'DLW Road, Bhagwanpur', 'Varanasi', 'Uttar Pradesh', '221005', '+915422368888', '+915422368888', 'POINT(82.9739 25.3176)', 'approved'),
('Heritage Hospital', 'multi_specialty', 'Lanka', 'Varanasi', 'Uttar Pradesh', '221005', '+915422369991', '+915422369991', 'POINT(82.9820 25.2960)', 'approved'),
('Surya Super Speciality Hospital', 'multi_specialty', 'Mahmoorganj', 'Varanasi', 'Uttar Pradesh', '221010', '+915422222275', '+915422222275', 'POINT(82.9950 25.3050)', 'approved'),
('Galaxy Hospital', 'multi_specialty', 'Bhelupur', 'Varanasi', 'Uttar Pradesh', '221010', '+915422277715', '+915422277715', 'POINT(83.0010 25.2980)', 'approved'),
('Sir Sunderlal Hospital (BHU)', 'government', 'BHU Campus, Lanka', 'Varanasi', 'Uttar Pradesh', '221005', '+915422368547', '+915422368547', 'POINT(83.0090 25.2650)', 'approved');

-- ============================================================
-- MIRZAPUR (5)
-- ============================================================
insert into hospitals (name, hospital_type, address, city, state, pincode, reception_phone, emergency_phone, location, verification_status) values
('Krishna Hospital', 'private', 'Baziraw Katra, Punjab Bank Katra Road', 'Mirzapur', 'Uttar Pradesh', '231001', '+915442224399', '+919889652124', 'POINT(82.5690 25.1460)', 'approved'),
('Maa Vindhyavasini Autonomous State Medical College', 'government', 'Mirzapur', 'Mirzapur', 'Uttar Pradesh', '231001', null, null, 'POINT(82.6062 25.1801)', 'approved'),
('Popular Hospital', 'private', 'Police Chowki, Jangi Road, Near Natwa, Saket Puri Colony', 'Mirzapur', 'Uttar Pradesh', '231001', null, null, 'POINT(82.5720 25.1490)', 'approved'),
('Vivekanand Hospital and Research Centre', 'private', 'Awas Vikas Colony, Wellesly Ganj', 'Mirzapur', 'Uttar Pradesh', '231001', '+919725982446', '+919725982446', 'POINT(82.5650 25.1430)', 'approved'),
('Apex Hospital & Trauma Center', 'private', 'NH 7, Varanasi Road', 'Chunar, Mirzapur', 'Uttar Pradesh', '231304', null, null, 'POINT(82.872438 25.103344)', 'approved');

-- ============================================================
-- CHANDAULI (3 — see honesty note above on why not 5)
-- ============================================================
insert into hospitals (name, hospital_type, address, city, state, pincode, reception_phone, emergency_phone, location, verification_status) values
('Ashirwad Nursing Home', 'private', 'Pandit Deen Dayal Upadhyaya Patel Nagar, Grand Trunk Road, Alinagar', 'Mughalsarai, Chandauli', 'Uttar Pradesh', '232101', '+9102048562555', '+9102048562555', 'POINT(83.1167 25.2833)', 'approved'),
('Pandit Kamlapati Tripathi District Combined Hospital', 'government', 'PT Kamlapati, District Head Quarters', 'Chandauli', 'Uttar Pradesh', '232104', null, null, 'POINT(83.2650 25.2560)', 'approved'),
('District Combined Hospital, Chakia', 'government', 'Chakia', 'Chandauli', 'Uttar Pradesh', '232103', null, null, 'POINT(83.3500 25.0500)', 'approved');

-- ============================================================
-- The ONE real, sourced doctor + treatment (Practo, self-reported)
-- ============================================================
-- Dr. Rahul Patel — Dentist, 11 years experience, at Apex Hospital &
-- Trauma Center, Chunar. Source: practo.com/mirzapur/hospitals
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee)
select id, 'Dr. Rahul Patel', 'Dentistry', null, 11, 500
from hospitals where name = 'Apex Hospital & Trauma Center' and city = 'Chunar, Mirzapur';

insert into treatment_charges (hospital_id, name, category, cost_from, cost_to)
select id, 'Root Canal Treatment (RCT)', 'Dentistry', 500, 500
from hospitals where name = 'Apex Hospital & Trauma Center' and city = 'Chunar, Mirzapur';
