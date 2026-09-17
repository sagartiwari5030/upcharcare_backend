const express = require("express");
const { supabaseAdmin } = require("../config/supabaseAdmin");
const { requireAuth } = require("../middleware/auth");
const { requireRole } = require("../middleware/requireRole");

const router = express.Router();

// Postgres/PostGIS geography columns accept WKT text on insert/update
// via Supabase's client, so we just build "POINT(lng lat)" — note the
// order is longitude THEN latitude, which trips people up constantly.
function toLocationWKT(latitude, longitude) {
  if (latitude == null || longitude == null) return undefined;
  return `POINT(${longitude} ${latitude})`;
}

// GET /api/hospitals/nearby — MUST be registered before GET /:id, or
// Express will match "nearby" as an :id parameter instead of this route.
router.get("/nearby", async (req, res) => {
  const lat = parseFloat(req.query.lat);
  const lng = parseFloat(req.query.lng);
  const radiusKm = req.query.radiusKm ? parseFloat(req.query.radiusKm) : 25;

  if (Number.isNaN(lat) || Number.isNaN(lng)) {
    return res.status(400).json({ error: "lat and lng query params are required" });
  }

  const { data, error } = await supabaseAdmin.rpc("nearby_hospitals", {
    lat, lng, radius_km: radiusKm,
  });

  if (error) return res.status(500).json({ error: error.message });
  res.json(data);
});

// GET /api/hospitals — public list of APPROVED hospitals only.
router.get("/", async (req, res) => {
  const { data, error } = await supabaseAdmin
    .from("hospitals")
    .select("id, name, city, hospital_type, emergency_phone")
    .eq("verification_status", "approved");

  if (error) return res.status(500).json({ error: error.message });
  res.json(data);
});

// GET /api/hospitals/:id — full detail, joined with doctors/treatments/beds.
router.get("/:id", async (req, res) => {
  const { id } = req.params;

  const [hospital, doctors, treatments, beds] = await Promise.all([
    supabaseAdmin.from("hospitals").select("*").eq("id", id).single(),
    supabaseAdmin.from("doctors").select("*").eq("hospital_id", id),
    supabaseAdmin.from("treatment_charges").select("*").eq("hospital_id", id),
    supabaseAdmin.from("bed_categories").select("*").eq("hospital_id", id),
  ]);

  if (hospital.error) return res.status(404).json({ error: "Hospital not found" });

  res.json({
    ...hospital.data,
    doctors: doctors.data ?? [],
    treatments: treatments.data ?? [],
    beds: beds.data ?? [],
  });
});

// POST /api/hospitals — register a new hospital. Any authenticated user
// can submit one; it starts as "pending" until an admin approves it
// (see routes/admin.js). The submitting user is linked as its owner.
// Accepts optional latitude/longitude — required for the hospital to
// ever show up in nearby-hospital search (see toLocationWKT above).
router.post("/", requireAuth, async (req, res) => {
  const {
    name, registration_number, hospital_type, address, city, state, pincode,
    reception_phone, emergency_phone, email, accepted_payment_modes, has_blood_bank,
    latitude, longitude,
  } = req.body;

  if (!name) return res.status(400).json({ error: "name is required" });

  const { data, error } = await supabaseAdmin
    .from("hospitals")
    .insert({
      name,
      registration_number,
      hospital_type,
      address,
      city,
      state,
      pincode,
      reception_phone,
      emergency_phone,
      email,
      accepted_payment_modes: accepted_payment_modes ?? [],
      has_blood_bank: has_blood_bank ?? false,
      location: toLocationWKT(latitude, longitude),
      created_by: req.profile.id,
      verification_status: "pending",
    })
    .select()
    .single();

  if (error) return res.status(500).json({ error: error.message });

  // Link the submitting user's profile to this hospital as staff.
  await supabaseAdmin.from("profiles").update({ role: "hospital_staff", hospital_id: data.id }).eq("id", req.profile.id);

  res.status(201).json(data);
});

// PATCH /api/hospitals/:id — hospital staff editing their own hospital's
// basic info. (Doctors/treatments/beds have their own routes below.)
router.patch("/:id", requireAuth, async (req, res) => {
  const { id } = req.params;

  if (req.profile.role !== "admin" && req.profile.hospital_id !== id) {
    return res.status(403).json({ error: "You can only edit your own hospital" });
  }

  const allowedFields = ["name", "address", "city", "state", "pincode", "reception_phone", "emergency_phone", "email", "accepted_payment_modes", "has_blood_bank", "photo_url"];
  const updates = Object.fromEntries(Object.entries(req.body).filter(([k]) => allowedFields.includes(k)));

  if (req.body.latitude != null && req.body.longitude != null) {
    updates.location = toLocationWKT(req.body.latitude, req.body.longitude);
  }

  updates.updated_at = new Date().toISOString();

  const { data, error } = await supabaseAdmin.from("hospitals").update(updates).eq("id", id).select().single();
  if (error) return res.status(500).json({ error: error.message });
  res.json(data);
});

module.exports = router;
