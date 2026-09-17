-- Seed data — DEMO/PLACEHOLDER facilities (doctors, treatments, beds)
-- for the 13 real hospitals seeded in seed_real_hospitals.sql.
--
-- EVERY name, fee, and price below is fictional filler, generated to
-- make the app demoable and testable end to end — NONE of it is real
-- reported data from these hospitals. Before this app is used by real
-- patients, each hospital's demo doctors/treatments/beds should be
-- deleted and replaced with what that hospital actually reports —
-- the hospital dashboard's edit/delete UI (built earlier) is exactly
-- the tool for that, hospital by hospital.
--
-- Run this AFTER seed_real_hospitals.sql.

-- ============================================================
-- Apex Hospital, Varanasi (Varanasi)
-- ============================================================
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Meera Rawat', 'General Surgery', 'MS General Surgery', 7, 650 from hospitals where name = 'Apex Hospital, Varanasi' and city = 'Varanasi';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Suresh Tiwari', 'General Medicine', 'MBBS, MD', 21, 450 from hospitals where name = 'Apex Hospital, Varanasi' and city = 'Varanasi';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Manoj Mehta', 'Cardiology', 'MD, DM Cardiology', 5, 700 from hospitals where name = 'Apex Hospital, Varanasi' and city = 'Varanasi';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Kidney Stone Removal', 'Surgery', 64726, 77160 from hospitals where name = 'Apex Hospital, Varanasi' and city = 'Varanasi';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Dialysis (per session)', 'Diagnostic', 2074, 2399 from hospitals where name = 'Apex Hospital, Varanasi' and city = 'Varanasi';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Bone Fracture Surgery', 'Surgery', 70713, 88931 from hospitals where name = 'Apex Hospital, Varanasi' and city = 'Varanasi';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'general', 'General Ward', 13, 7, 1150 from hospitals where name = 'Apex Hospital, Varanasi' and city = 'Varanasi';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'private', 'Private Room', 2, 0, 4000 from hospitals where name = 'Apex Hospital, Varanasi' and city = 'Varanasi';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu', 'ICU', 7, 4, 6000 from hospitals where name = 'Apex Hospital, Varanasi' and city = 'Varanasi';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu_ventilator', 'ICU (Ventilator)', 5, 2, 9750 from hospitals where name = 'Apex Hospital, Varanasi' and city = 'Varanasi';

-- ============================================================
-- Heritage Hospital (Varanasi)
-- ============================================================
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Anil Chauhan', 'General Surgery', 'MS General Surgery', 22, 750 from hospitals where name = 'Heritage Hospital' and city = 'Varanasi';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Meera Mishra', 'Gynecology & Obstetrics', 'MS OBG', 17, 450 from hospitals where name = 'Heritage Hospital' and city = 'Varanasi';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Vivek Joshi', 'General Medicine', 'MBBS, MD', 5, 700 from hospitals where name = 'Heritage Hospital' and city = 'Varanasi';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Dialysis (per session)', 'Diagnostic', 2143, 2482 from hospitals where name = 'Heritage Hospital' and city = 'Varanasi';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Bone Fracture Surgery', 'Surgery', 58700, 84659 from hospitals where name = 'Heritage Hospital' and city = 'Varanasi';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Cataract / Myopia Correction', 'Diagnostic', 18150, 25289 from hospitals where name = 'Heritage Hospital' and city = 'Varanasi';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'general', 'General Ward', 7, 3, 1150 from hospitals where name = 'Heritage Hospital' and city = 'Varanasi';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'private', 'Private Room', 3, 1, 2750 from hospitals where name = 'Heritage Hospital' and city = 'Varanasi';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu', 'ICU', 8, 4, 7250 from hospitals where name = 'Heritage Hospital' and city = 'Varanasi';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu_ventilator', 'ICU (Ventilator)', 7, 2, 11750 from hospitals where name = 'Heritage Hospital' and city = 'Varanasi';

-- ============================================================
-- Surya Super Speciality Hospital (Varanasi)
-- ============================================================
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Meera Pandey', 'Cardiology', 'MD, DM Cardiology', 22, 750 from hospitals where name = 'Surya Super Speciality Hospital' and city = 'Varanasi';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Rohit Yadav', 'General Surgery', 'MS General Surgery', 8, 650 from hospitals where name = 'Surya Super Speciality Hospital' and city = 'Varanasi';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Shweta Sharma', 'Dermatology', 'MD Dermatology', 20, 600 from hospitals where name = 'Surya Super Speciality Hospital' and city = 'Varanasi';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Kidney Stone Removal', 'Surgery', 70176, 82405 from hospitals where name = 'Surya Super Speciality Hospital' and city = 'Varanasi';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Hydrocele Surgery', 'Surgery', 23752, 30277 from hospitals where name = 'Surya Super Speciality Hospital' and city = 'Varanasi';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Cataract / Myopia Correction', 'Diagnostic', 28189, 34512 from hospitals where name = 'Surya Super Speciality Hospital' and city = 'Varanasi';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'general', 'General Ward', 18, 8, 900 from hospitals where name = 'Surya Super Speciality Hospital' and city = 'Varanasi';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'private', 'Private Room', 5, 4, 3750 from hospitals where name = 'Surya Super Speciality Hospital' and city = 'Varanasi';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu', 'ICU', 5, 5, 7250 from hospitals where name = 'Surya Super Speciality Hospital' and city = 'Varanasi';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu_ventilator', 'ICU (Ventilator)', 8, 7, 10000 from hospitals where name = 'Surya Super Speciality Hospital' and city = 'Varanasi';

-- ============================================================
-- Galaxy Hospital (Varanasi)
-- ============================================================
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Vivek Yadav', 'Pediatrics', 'MD Pediatrics', 21, 500 from hospitals where name = 'Galaxy Hospital' and city = 'Varanasi';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Manoj Agarwal', 'General Surgery', 'MS General Surgery', 14, 800 from hospitals where name = 'Galaxy Hospital' and city = 'Varanasi';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Rajesh Nair', 'ENT', 'MS ENT', 18, 600 from hospitals where name = 'Galaxy Hospital' and city = 'Varanasi';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'C-Section Delivery', 'Maternity', 43592, 53596 from hospitals where name = 'Galaxy Hospital' and city = 'Varanasi';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Normal Delivery', 'Maternity', 30280, 36935 from hospitals where name = 'Galaxy Hospital' and city = 'Varanasi';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Cataract / Myopia Correction', 'Diagnostic', 27977, 34841 from hospitals where name = 'Galaxy Hospital' and city = 'Varanasi';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'general', 'General Ward', 25, 2, 1150 from hospitals where name = 'Galaxy Hospital' and city = 'Varanasi';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'private', 'Private Room', 8, 7, 3500 from hospitals where name = 'Galaxy Hospital' and city = 'Varanasi';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu', 'ICU', 10, 0, 8000 from hospitals where name = 'Galaxy Hospital' and city = 'Varanasi';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu_ventilator', 'ICU (Ventilator)', 3, 2, 14000 from hospitals where name = 'Galaxy Hospital' and city = 'Varanasi';

-- ============================================================
-- Sir Sunderlal Hospital (BHU) (Varanasi)
-- ============================================================
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Manoj Nair', 'Cardiology', 'MD, DM Cardiology', 3, 1050 from hospitals where name = 'Sir Sunderlal Hospital (BHU)' and city = 'Varanasi';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Meera Yadav', 'General Medicine', 'MBBS, MD', 19, 500 from hospitals where name = 'Sir Sunderlal Hospital (BHU)' and city = 'Varanasi';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Suresh Chauhan', 'Orthopedics', 'MS Ortho', 19, 700 from hospitals where name = 'Sir Sunderlal Hospital (BHU)' and city = 'Varanasi';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Kidney Stone Removal', 'Surgery', 69985, 82646 from hospitals where name = 'Sir Sunderlal Hospital (BHU)' and city = 'Varanasi';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Appendix Surgery', 'Surgery', 47674, 59863 from hospitals where name = 'Sir Sunderlal Hospital (BHU)' and city = 'Varanasi';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Root Canal Treatment', 'Dentistry', 4172, 5372 from hospitals where name = 'Sir Sunderlal Hospital (BHU)' and city = 'Varanasi';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'general', 'General Ward', 25, 10, 1150 from hospitals where name = 'Sir Sunderlal Hospital (BHU)' and city = 'Varanasi';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'private', 'Private Room', 2, 0, 3750 from hospitals where name = 'Sir Sunderlal Hospital (BHU)' and city = 'Varanasi';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu', 'ICU', 6, 1, 5500 from hospitals where name = 'Sir Sunderlal Hospital (BHU)' and city = 'Varanasi';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu_ventilator', 'ICU (Ventilator)', 5, 4, 9500 from hospitals where name = 'Sir Sunderlal Hospital (BHU)' and city = 'Varanasi';

-- ============================================================
-- Krishna Hospital (Mirzapur)
-- ============================================================
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Priya Mishra', 'General Surgery', 'MS General Surgery', 7, 600 from hospitals where name = 'Krishna Hospital' and city = 'Mirzapur';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Ashok Yadav', 'Cardiology', 'MD, DM Cardiology', 11, 800 from hospitals where name = 'Krishna Hospital' and city = 'Mirzapur';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Ritu Chauhan', 'Gynecology & Obstetrics', 'MS OBG', 9, 750 from hospitals where name = 'Krishna Hospital' and city = 'Mirzapur';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Dialysis (per session)', 'Diagnostic', 1819, 2323 from hospitals where name = 'Krishna Hospital' and city = 'Mirzapur';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Kidney Stone Removal', 'Surgery', 67009, 84332 from hospitals where name = 'Krishna Hospital' and city = 'Mirzapur';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Hydrocele Surgery', 'Surgery', 26118, 35706 from hospitals where name = 'Krishna Hospital' and city = 'Mirzapur';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'general', 'General Ward', 22, 14, 900 from hospitals where name = 'Krishna Hospital' and city = 'Mirzapur';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'private', 'Private Room', 5, 1, 2750 from hospitals where name = 'Krishna Hospital' and city = 'Mirzapur';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu', 'ICU', 7, 0, 7750 from hospitals where name = 'Krishna Hospital' and city = 'Mirzapur';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu_ventilator', 'ICU (Ventilator)', 10, 3, 13500 from hospitals where name = 'Krishna Hospital' and city = 'Mirzapur';

-- ============================================================
-- Maa Vindhyavasini Autonomous State Medical College (Mirzapur)
-- ============================================================
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Vikram Rawat', 'Gynecology & Obstetrics', 'MS OBG', 4, 500 from hospitals where name = 'Maa Vindhyavasini Autonomous State Medical College' and city = 'Mirzapur';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Pooja Joshi', 'General Medicine', 'MBBS, MD', 11, 550 from hospitals where name = 'Maa Vindhyavasini Autonomous State Medical College' and city = 'Mirzapur';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Ashok Rawat', 'ENT', 'MS ENT', 7, 600 from hospitals where name = 'Maa Vindhyavasini Autonomous State Medical College' and city = 'Mirzapur';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Root Canal Treatment', 'Dentistry', 3937, 5963 from hospitals where name = 'Maa Vindhyavasini Autonomous State Medical College' and city = 'Mirzapur';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Kidney Stone Removal', 'Surgery', 58338, 73457 from hospitals where name = 'Maa Vindhyavasini Autonomous State Medical College' and city = 'Mirzapur';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Cataract / Myopia Correction', 'Diagnostic', 16545, 24133 from hospitals where name = 'Maa Vindhyavasini Autonomous State Medical College' and city = 'Mirzapur';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'general', 'General Ward', 27, 13, 1150 from hospitals where name = 'Maa Vindhyavasini Autonomous State Medical College' and city = 'Mirzapur';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'private', 'Private Room', 8, 6, 4250 from hospitals where name = 'Maa Vindhyavasini Autonomous State Medical College' and city = 'Mirzapur';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu', 'ICU', 2, 2, 8000 from hospitals where name = 'Maa Vindhyavasini Autonomous State Medical College' and city = 'Mirzapur';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu_ventilator', 'ICU (Ventilator)', 3, 0, 12000 from hospitals where name = 'Maa Vindhyavasini Autonomous State Medical College' and city = 'Mirzapur';

-- ============================================================
-- Popular Hospital (Mirzapur)
-- ============================================================
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Rajesh Rawat', 'Cardiology', 'MD, DM Cardiology', 20, 850 from hospitals where name = 'Popular Hospital' and city = 'Mirzapur';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Shweta Nair', 'ENT', 'MS ENT', 8, 550 from hospitals where name = 'Popular Hospital' and city = 'Mirzapur';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Meera Gupta', 'General Medicine', 'MBBS, MD', 5, 550 from hospitals where name = 'Popular Hospital' and city = 'Mirzapur';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Root Canal Treatment', 'Dentistry', 4671, 5874 from hospitals where name = 'Popular Hospital' and city = 'Mirzapur';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'C-Section Delivery', 'Maternity', 43056, 62902 from hospitals where name = 'Popular Hospital' and city = 'Mirzapur';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Normal Delivery', 'Maternity', 33905, 39935 from hospitals where name = 'Popular Hospital' and city = 'Mirzapur';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'general', 'General Ward', 11, 6, 1150 from hospitals where name = 'Popular Hospital' and city = 'Mirzapur';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'private', 'Private Room', 9, 3, 4000 from hospitals where name = 'Popular Hospital' and city = 'Mirzapur';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu', 'ICU', 2, 0, 7000 from hospitals where name = 'Popular Hospital' and city = 'Mirzapur';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu_ventilator', 'ICU (Ventilator)', 2, 1, 11000 from hospitals where name = 'Popular Hospital' and city = 'Mirzapur';

-- ============================================================
-- Vivekanand Hospital and Research Centre (Mirzapur)
-- ============================================================
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Vivek Tiwari', 'Dermatology', 'MD Dermatology', 18, 750 from hospitals where name = 'Vivekanand Hospital and Research Centre' and city = 'Mirzapur';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Kavita Rawat', 'Orthopedics', 'MS Ortho', 9, 700 from hospitals where name = 'Vivekanand Hospital and Research Centre' and city = 'Mirzapur';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Vikram Kumar', 'Gynecology & Obstetrics', 'MS OBG', 13, 450 from hospitals where name = 'Vivekanand Hospital and Research Centre' and city = 'Mirzapur';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Normal Delivery', 'Maternity', 27811, 37930 from hospitals where name = 'Vivekanand Hospital and Research Centre' and city = 'Mirzapur';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Dialysis (per session)', 'Diagnostic', 2043, 2383 from hospitals where name = 'Vivekanand Hospital and Research Centre' and city = 'Mirzapur';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Bone Fracture Surgery', 'Surgery', 38727, 88508 from hospitals where name = 'Vivekanand Hospital and Research Centre' and city = 'Mirzapur';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'general', 'General Ward', 8, 2, 900 from hospitals where name = 'Vivekanand Hospital and Research Centre' and city = 'Mirzapur';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'private', 'Private Room', 3, 1, 4000 from hospitals where name = 'Vivekanand Hospital and Research Centre' and city = 'Mirzapur';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu', 'ICU', 3, 1, 7750 from hospitals where name = 'Vivekanand Hospital and Research Centre' and city = 'Mirzapur';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu_ventilator', 'ICU (Ventilator)', 2, 2, 9500 from hospitals where name = 'Vivekanand Hospital and Research Centre' and city = 'Mirzapur';

-- ============================================================
-- Apex Hospital & Trauma Center (Chunar, Mirzapur)
-- ============================================================
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Sunita Yadav', 'ENT', 'MS ENT', 11, 500 from hospitals where name = 'Apex Hospital & Trauma Center' and city = 'Chunar, Mirzapur';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Neha Tiwari', 'Cardiology', 'MD, DM Cardiology', 10, 950 from hospitals where name = 'Apex Hospital & Trauma Center' and city = 'Chunar, Mirzapur';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Meera Sharma', 'Pediatrics', 'MD Pediatrics', 12, 450 from hospitals where name = 'Apex Hospital & Trauma Center' and city = 'Chunar, Mirzapur';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Root Canal Treatment', 'Dentistry', 2297, 3535 from hospitals where name = 'Apex Hospital & Trauma Center' and city = 'Chunar, Mirzapur';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Hydrocele Surgery', 'Surgery', 27508, 38596 from hospitals where name = 'Apex Hospital & Trauma Center' and city = 'Chunar, Mirzapur';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Cataract / Myopia Correction', 'Diagnostic', 24224, 31043 from hospitals where name = 'Apex Hospital & Trauma Center' and city = 'Chunar, Mirzapur';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'general', 'General Ward', 8, 8, 900 from hospitals where name = 'Apex Hospital & Trauma Center' and city = 'Chunar, Mirzapur';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'private', 'Private Room', 10, 4, 3000 from hospitals where name = 'Apex Hospital & Trauma Center' and city = 'Chunar, Mirzapur';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu', 'ICU', 7, 1, 6250 from hospitals where name = 'Apex Hospital & Trauma Center' and city = 'Chunar, Mirzapur';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu_ventilator', 'ICU (Ventilator)', 7, 4, 10250 from hospitals where name = 'Apex Hospital & Trauma Center' and city = 'Chunar, Mirzapur';

-- ============================================================
-- Ashirwad Nursing Home (Mughalsarai, Chandauli)
-- ============================================================
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Sanjay Kumar', 'Dermatology', 'MD Dermatology', 19, 750 from hospitals where name = 'Ashirwad Nursing Home' and city = 'Mughalsarai, Chandauli';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Anjali Tiwari', 'ENT', 'MS ENT', 12, 600 from hospitals where name = 'Ashirwad Nursing Home' and city = 'Mughalsarai, Chandauli';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Suresh Agarwal', 'Pediatrics', 'MD Pediatrics', 11, 450 from hospitals where name = 'Ashirwad Nursing Home' and city = 'Mughalsarai, Chandauli';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'C-Section Delivery', 'Maternity', 45093, 57055 from hospitals where name = 'Ashirwad Nursing Home' and city = 'Mughalsarai, Chandauli';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Dialysis (per session)', 'Diagnostic', 1788, 2397 from hospitals where name = 'Ashirwad Nursing Home' and city = 'Mughalsarai, Chandauli';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Hydrocele Surgery', 'Surgery', 23450, 35067 from hospitals where name = 'Ashirwad Nursing Home' and city = 'Mughalsarai, Chandauli';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'general', 'General Ward', 12, 10, 1150 from hospitals where name = 'Ashirwad Nursing Home' and city = 'Mughalsarai, Chandauli';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'private', 'Private Room', 10, 7, 3500 from hospitals where name = 'Ashirwad Nursing Home' and city = 'Mughalsarai, Chandauli';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu', 'ICU', 2, 0, 8000 from hospitals where name = 'Ashirwad Nursing Home' and city = 'Mughalsarai, Chandauli';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu_ventilator', 'ICU (Ventilator)', 8, 4, 9250 from hospitals where name = 'Ashirwad Nursing Home' and city = 'Mughalsarai, Chandauli';

-- ============================================================
-- Pandit Kamlapati Tripathi District Combined Hospital (Chandauli)
-- ============================================================
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Meera Nair', 'General Medicine', 'MBBS, MD', 20, 750 from hospitals where name = 'Pandit Kamlapati Tripathi District Combined Hospital' and city = 'Chandauli';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Manoj Yadav', 'Orthopedics', 'MS Ortho', 6, 500 from hospitals where name = 'Pandit Kamlapati Tripathi District Combined Hospital' and city = 'Chandauli';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Priya Agarwal', 'General Surgery', 'MS General Surgery', 20, 600 from hospitals where name = 'Pandit Kamlapati Tripathi District Combined Hospital' and city = 'Chandauli';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Normal Delivery', 'Maternity', 29052, 36265 from hospitals where name = 'Pandit Kamlapati Tripathi District Combined Hospital' and city = 'Chandauli';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Hydrocele Surgery', 'Surgery', 27041, 34085 from hospitals where name = 'Pandit Kamlapati Tripathi District Combined Hospital' and city = 'Chandauli';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Bone Fracture Surgery', 'Surgery', 37741, 74443 from hospitals where name = 'Pandit Kamlapati Tripathi District Combined Hospital' and city = 'Chandauli';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'general', 'General Ward', 17, 1, 1150 from hospitals where name = 'Pandit Kamlapati Tripathi District Combined Hospital' and city = 'Chandauli';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'private', 'Private Room', 5, 5, 3250 from hospitals where name = 'Pandit Kamlapati Tripathi District Combined Hospital' and city = 'Chandauli';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu', 'ICU', 3, 2, 8500 from hospitals where name = 'Pandit Kamlapati Tripathi District Combined Hospital' and city = 'Chandauli';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu_ventilator', 'ICU (Ventilator)', 10, 6, 13750 from hospitals where name = 'Pandit Kamlapati Tripathi District Combined Hospital' and city = 'Chandauli';

-- ============================================================
-- District Combined Hospital, Chakia (Chandauli)
-- ============================================================
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Rohit Agarwal', 'Orthopedics', 'MS Ortho', 3, 800 from hospitals where name = 'District Combined Hospital, Chakia' and city = 'Chandauli';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Rohit Pandey', 'General Surgery', 'MS General Surgery', 16, 750 from hospitals where name = 'District Combined Hospital, Chakia' and city = 'Chandauli';
insert into doctors (hospital_id, name, specialty, qualification, experience_years, consultation_fee) select id, 'Dr. Rajesh Singh', 'ENT', 'MS ENT', 6, 450 from hospitals where name = 'District Combined Hospital, Chakia' and city = 'Chandauli';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Cataract / Myopia Correction', 'Diagnostic', 22711, 30533 from hospitals where name = 'District Combined Hospital, Chakia' and city = 'Chandauli';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Normal Delivery', 'Maternity', 23269, 36810 from hospitals where name = 'District Combined Hospital, Chakia' and city = 'Chandauli';
insert into treatment_charges (hospital_id, name, category, cost_from, cost_to) select id, 'Dialysis (per session)', 'Diagnostic', 1858, 2314 from hospitals where name = 'District Combined Hospital, Chakia' and city = 'Chandauli';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'general', 'General Ward', 13, 3, 900 from hospitals where name = 'District Combined Hospital, Chakia' and city = 'Chandauli';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'private', 'Private Room', 5, 3, 3750 from hospitals where name = 'District Combined Hospital, Chakia' and city = 'Chandauli';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu', 'ICU', 6, 6, 5750 from hospitals where name = 'District Combined Hospital, Chakia' and city = 'Chandauli';
insert into bed_categories (hospital_id, type, label, total_count, available_count, cost_per_day) select id, 'icu_ventilator', 'ICU (Ventilator)', 6, 2, 14000 from hospitals where name = 'District Combined Hospital, Chakia' and city = 'Chandauli';
