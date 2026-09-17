require("dotenv").config();
const express = require("express");
const cors = require("cors");

const hospitalsRoutes = require("./routes/hospitals");
const doctorsRoutes = require("./routes/doctors");
const treatmentsRoutes = require("./routes/treatments");
const bedsRoutes = require("./routes/beds");
const adminRoutes = require("./routes/admin");
const analyticsRoutes = require("./routes/analytics");

const app = express();
app.use(cors());
app.use(express.json());

app.get("/health", (req, res) => res.json({ status: "ok" }));

app.use("/api/hospitals", hospitalsRoutes);
app.use("/api", doctorsRoutes);     // /api/hospitals/:id/doctors, /api/doctors/:id
app.use("/api", treatmentsRoutes);  // /api/hospitals/:id/treatments, /api/treatments/:id
app.use("/api", bedsRoutes);        // /api/hospitals/:id/beds
app.use("/api", analyticsRoutes);   // /api/hospitals/:id/interest, /api/hospitals/:id/analytics
app.use("/api/admin", adminRoutes);

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`Apna Aspatal backend running on http://localhost:${PORT}`);
});
