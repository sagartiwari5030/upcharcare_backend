const express = require("express");
const { supabaseAdmin } = require("../config/supabaseAdmin");
const { requireAuth } = require("../middleware/auth");
const { requireRole } = require("../middleware/requireRole");

const router = express.Router();

// GET /api/admin/hospitals/pending — platform admin only
router.get("/hospitals/pending", requireAuth, requireRole("admin"), async (req, res) => {
  const { data, error } = await supabaseAdmin.from("hospitals").select("*").eq("verification_status", "pending");
  if (error) return res.status(500).json({ error: error.message });
  res.json(data);
});

// POST /api/admin/hospitals/:id/approve
router.post("/hospitals/:id/approve", requireAuth, requireRole("admin"), async (req, res) => {
  const { data, error } = await supabaseAdmin
    .from("hospitals")
    .update({ verification_status: "approved", updated_at: new Date().toISOString() })
    .eq("id", req.params.id)
    .select()
    .single();

  if (error) return res.status(500).json({ error: error.message });
  res.json(data);
});

// POST /api/admin/hospitals/:id/reject
router.post("/hospitals/:id/reject", requireAuth, requireRole("admin"), async (req, res) => {
  const { data, error } = await supabaseAdmin
    .from("hospitals")
    .update({ verification_status: "rejected", updated_at: new Date().toISOString() })
    .eq("id", req.params.id)
    .select()
    .single();

  if (error) return res.status(500).json({ error: error.message });
  res.json(data);
});

module.exports = router;
