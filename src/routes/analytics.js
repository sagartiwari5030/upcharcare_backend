const express = require("express");
const { supabaseAdmin } = require("../config/supabaseAdmin");
const { requireAuth } = require("../middleware/auth");
const { ownsHospital } = require("../middleware/ownsHospital");

const router = express.Router();

// POST /api/hospitals/:hospitalId/interest — PUBLIC, no auth required.
// Called by the patient app when someone views a doctor or treatment.
// Body: { kind: "doctor" | "treatment", doctorId?, treatmentId? }
router.post("/hospitals/:hospitalId/interest", async (req, res) => {
  const { kind, doctorId, treatmentId } = req.body;
  if (kind !== "doctor" && kind !== "treatment") {
    return res.status(400).json({ error: "kind must be 'doctor' or 'treatment'" });
  }
  if (kind === "doctor" && !doctorId) return res.status(400).json({ error: "doctorId is required" });
  if (kind === "treatment" && !treatmentId) return res.status(400).json({ error: "treatmentId is required" });

  const { error } = await supabaseAdmin.from("interest_events").insert({
    hospital_id: req.params.hospitalId,
    kind,
    doctor_id: kind === "doctor" ? doctorId : null,
    treatment_id: kind === "treatment" ? treatmentId : null,
  });

  if (error) return res.status(500).json({ error: error.message });
  res.status(201).json({ ok: true });
});

// GET /api/hospitals/:hospitalId/analytics — hospital staff only.
// Returns view counts grouped by doctor and by treatment.
router.get(
  "/hospitals/:hospitalId/analytics",
  requireAuth,
  ownsHospital((req) => req.params.hospitalId),
  async (req, res) => {
    const { data, error } = await supabaseAdmin
      .from("interest_events")
      .select("kind, doctor_id, treatment_id")
      .eq("hospital_id", req.params.hospitalId);

    if (error) return res.status(500).json({ error: error.message });

    const byDoctor = {};
    const byTreatment = {};
    for (const row of data) {
      if (row.kind === "doctor") byDoctor[row.doctor_id] = (byDoctor[row.doctor_id] || 0) + 1;
      if (row.kind === "treatment") byTreatment[row.treatment_id] = (byTreatment[row.treatment_id] || 0) + 1;
    }

    res.json({ byDoctor, byTreatment, totalEvents: data.length });
  }
);

module.exports = router;
