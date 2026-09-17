const express = require("express");
const { supabaseAdmin } = require("../config/supabaseAdmin");
const { requireAuth } = require("../middleware/auth");
const { ownsHospital } = require("../middleware/ownsHospital");

const router = express.Router();

// GET /api/treatments/search?name=X — which APPROVED hospitals offer a
// treatment matching this name, with pricing. Powers the "Best Hospital
// For..." comparison screen (C-section, kidney stone, etc.) — matches
// loosely (ilike) against BOTH the name and category columns, since
// hospital staff don't always put the searchable term in the same
// field consistently (e.g. "C-Section" typed as the category with a
// generic name like "Operation").
router.get("/treatments/search", async (req, res) => {
  const name = (req.query.name || "").trim();
  if (!name) return res.status(400).json({ error: "name query param is required" });

  const { data, error } = await supabaseAdmin
    .from("treatment_charges")
    .select("*, hospitals!inner(name, city, emergency_phone, verification_status)")
    .eq("hospitals.verification_status", "approved")
    .or(`name.ilike.%${name}%,category.ilike.%${name}%`)
    .order("cost_from", { ascending: true });

  if (error) return res.status(500).json({ error: error.message });
  res.json(data);
});

router.get("/hospitals/:hospitalId/treatments", async (req, res) => {
  const { data, error } = await supabaseAdmin.from("treatment_charges").select("*").eq("hospital_id", req.params.hospitalId);
  if (error) return res.status(500).json({ error: error.message });
  res.json(data);
});

router.post(
  "/hospitals/:hospitalId/treatments",
  requireAuth,
  ownsHospital((req) => req.params.hospitalId),
  async (req, res) => {
    const { name, category, cost_from, cost_to } = req.body;
    if (!name || cost_from == null || cost_to == null) {
      return res.status(400).json({ error: "name, cost_from, and cost_to are required" });
    }

    const { data, error } = await supabaseAdmin
      .from("treatment_charges")
      .insert({ hospital_id: req.params.hospitalId, name, category, cost_from, cost_to })
      .select()
      .single();

    if (error) return res.status(500).json({ error: error.message });
    res.status(201).json(data);
  }
);

router.patch("/treatments/:id", requireAuth, async (req, res) => {
  const { data: row, error: findError } = await supabaseAdmin.from("treatment_charges").select("hospital_id").eq("id", req.params.id).single();
  if (findError) return res.status(404).json({ error: "Treatment not found" });

  if (req.profile.role !== "admin" && req.profile.hospital_id !== row.hospital_id) {
    return res.status(403).json({ error: "You can only edit your own hospital's treatments" });
  }

  const allowedFields = ["name", "category", "cost_from", "cost_to"];
  const updates = Object.fromEntries(Object.entries(req.body).filter(([k]) => allowedFields.includes(k)));
  updates.updated_at = new Date().toISOString();

  const { data, error } = await supabaseAdmin.from("treatment_charges").update(updates).eq("id", req.params.id).select().single();
  if (error) return res.status(500).json({ error: error.message });
  res.json(data);
});

router.delete("/treatments/:id", requireAuth, async (req, res) => {
  const { data: row, error: findError } = await supabaseAdmin.from("treatment_charges").select("hospital_id").eq("id", req.params.id).single();
  if (findError) return res.status(404).json({ error: "Treatment not found" });

  if (req.profile.role !== "admin" && req.profile.hospital_id !== row.hospital_id) {
    return res.status(403).json({ error: "You can only delete your own hospital's treatments" });
  }

  const { error } = await supabaseAdmin.from("treatment_charges").delete().eq("id", req.params.id);
  if (error) return res.status(500).json({ error: error.message });
  res.status(204).send();
});

module.exports = router;
