// Use after requireAuth. Restricts a route to specific roles, e.g.
// router.post("/approve", requireAuth, requireRole("admin"), handler)

function requireRole(...allowedRoles) {
  return (req, res, next) => {
    if (!req.profile || !allowedRoles.includes(req.profile.role)) {
      return res.status(403).json({ error: "Insufficient permissions for this action" });
    }
    next();
  };
}

module.exports = { requireRole };
