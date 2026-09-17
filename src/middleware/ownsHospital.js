// Checks the caller is either an admin, or hospital_staff belonging to the
// specific hospital_id being written to. Reused by doctors/treatments/beds
// routes, since they all follow the same "own hospital only" rule.

function ownsHospital(getHospitalId) {
  return async (req, res, next) => {
    if (req.profile.role === "admin") return next();

    const hospitalId = await getHospitalId(req);
    if (req.profile.role === "hospital_staff" && req.profile.hospital_id === hospitalId) {
      return next();
    }
    return res.status(403).json({ error: "You can only manage your own hospital's data" });
  };
}

module.exports = { ownsHospital };
