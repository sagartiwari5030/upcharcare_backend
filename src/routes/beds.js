const express = require("express");
const { supabaseAdmin } = require("../config/supabaseAdmin");
const { requireAuth } = require("../middleware/auth");
const { ownsHospital } = require("../middleware/ownsHospital");

const router = express.Router();

router.get("/hospitals/:hospitalId/beds", async (req, res) => {
  const { data, error } = await supabaseAdmin.from("bed_categories").select("*").eq("hospital_id", req.params.hospitalId);
  if (error) return res.status(500).json({ error: error.message });
  res.json(data);
});

// Beds use upsert on (hospital_id, type) — a hospital has at most one row
// per bed type, and staff will mostly be updating available_count, not
// creating rows from scratch each time.
router.put(
  "/hospitals/:hospitalId/beds/:type",
  requireAuth,
  ownsHospital((req) => req.params.hospitalId),
  async (req, res) => {
    const { label, total_count, available_count, cost_per_day } = req.body;
    if (available_count == null || cost_per_day == null) {
      return res.status(400).json({ error: "available_count and cost_per_day are required" });
    }

    const { data, error } = await supabaseAdmin
      .from("bed_categories")
      .upsert(
        {
          hospital_id: req.params.hospitalId,
          type: req.params.type,
          label: label ?? req.params.type,
          total_count,
          available_count,
          cost_per_day,
          updated_at: new Date().toISOString(),
        },
        { onConflict: "hospital_id,type" }
      )
      .select()
      .single();

    if (error) return res.status(500).json({ error: error.message });
    res.json(data);
  }
);

module.exports = router;
