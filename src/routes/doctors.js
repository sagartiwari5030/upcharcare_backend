const express = require("express");
const { supabaseAdmin } = require("../config/supabaseAdmin");
const { requireAuth } = require("../middleware/auth");
const { ownsHospital } = require("../middleware/ownsHospital");

const router = express.Router();

// GET /api/doctors — every doctor across every APPROVED hospital, for
// the patient app's Consult tab. This must come before the
// /hospitals/:hospitalId/doctors route below has any chance of
// confusion, though the paths don't actually collide here.
router.get("/doctors", async (req, res) => {
  const { data, error } = await supabaseAdmin
    .from("doctors")
    .select("*, hospitals!inner(name, verification_status)")
    .eq("hospitals.verification_status", "approved");

  if (error) return res.status(500).json({ error: error.message });
  res.json(data);
});

// GET /api/hospitals/:hospitalId/doctors — public
router.get("/hospitals/:hospitalId/doctors", async (req, res) => {
  const { data, error } = await supabaseAdmin.from("doctors").select("*").eq("hospital_id", req.params.hospitalId);
  if (error) return res.status(500).json({ error: error.message });
  res.json(data);
});

// POST /api/hospitals/:hospitalId/doctors — hospital staff only, own hospital
router.post(
  "/hospitals/:hospitalId/doctors",
  requireAuth,
  ownsHospital((req) => req.params.hospitalId),
  async (req, res) => {
    const { name, specialty, qualification, experience_years, consultation_fee, available_days, available_time_from, available_time_to, photo_url } = req.body;
    if (!name || !specialty) return res.status(400).json({ error: "name and specialty are required" });

    const { data, error } = await supabaseAdmin
      .from("doctors")
      .insert({
        hospital_id: req.params.hospitalId,
        name, specialty, qualification, experience_years, consultation_fee,
        available_days, available_time_from, available_time_to, photo_url,
      })
      .select()
      .single();

    if (error) return res.status(500).json({ error: error.message });
    res.status(201).json(data);
  }
);

// PATCH /api/doctors/:id — hospital staff only, must own the doctor's hospital
router.patch("/doctors/:id", requireAuth, async (req, res) => {
  const { data: doctor, error: findError } = await supabaseAdmin.from("doctors").select("hospital_id").eq("id", req.params.id).single();
  if (findError) return res.status(404).json({ error: "Doctor not found" });

  if (req.profile.role !== "admin" && req.profile.hospital_id !== doctor.hospital_id) {
    return res.status(403).json({ error: "You can only edit your own hospital's doctors" });
  }

  const allowedFields = ["name", "specialty", "qualification", "experience_years", "consultation_fee", "available_days", "available_time_from", "available_time_to", "photo_url"];
  const updates = Object.fromEntries(Object.entries(req.body).filter(([k]) => allowedFields.includes(k)));
  updates.updated_at = new Date().toISOString();

  const { data, error } = await supabaseAdmin.from("doctors").update(updates).eq("id", req.params.id).select().single();
  if (error) return res.status(500).json({ error: error.message });
  res.json(data);
});

// DELETE /api/doctors/:id
router.delete("/doctors/:id", requireAuth, async (req, res) => {
  const { data: doctor, error: findError } = await supabaseAdmin.from("doctors").select("hospital_id").eq("id", req.params.id).single();
  if (findError) return res.status(404).json({ error: "Doctor not found" });

  if (req.profile.role !== "admin" && req.profile.hospital_id !== doctor.hospital_id) {
    return res.status(403).json({ error: "You can only delete your own hospital's doctors" });
  }

  const { error } = await supabaseAdmin.from("doctors").delete().eq("id", req.params.id);
  if (error) return res.status(500).json({ error: error.message });
  res.status(204).send();
});

module.exports = router;
