// Verifies the Supabase JWT sent by the app (Authorization: Bearer <token>)
// and attaches the requesting user + their profile (with role) to req.
// Every route that needs to know "who is calling, and what's their role"
// starts with this.

const { supabaseAdmin } = require("../config/supabaseAdmin");

async function requireAuth(req, res, next) {
  const header = req.headers.authorization || "";
  const token = header.startsWith("Bearer ") ? header.slice(7) : null;

  if (!token) {
    return res.status(401).json({ error: "Missing bearer token" });
  }

  const { data: userData, error: userError } = await supabaseAdmin.auth.getUser(token);
  if (userError || !userData.user) {
    return res.status(401).json({ error: "Invalid or expired token" });
  }

  const { data: profile, error: profileError } = await supabaseAdmin
    .from("profiles")
    .select("*")
    .eq("id", userData.user.id)
    .single();

  if (profileError || !profile) {
    return res.status(403).json({ error: "No profile found for this user" });
  }

  req.user = userData.user;
  req.profile = profile;
  next();
}

module.exports = { requireAuth };
