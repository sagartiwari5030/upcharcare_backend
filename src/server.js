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

// CORS — explicit allowlist rather than wide-open, now that this is a
// real production backend. ALLOWED_ORIGINS in .env is a comma-separated
// list; sensible defaults cover local dev + your real domain so you
// don't have to set it just to get started. Requests with no Origin
// header (mobile apps, curl, server-to-server) are always allowed —
// CORS is a browser-enforced concept and doesn't apply to them anyway.
const defaultOrigins = [
  "https://upcharcare.com",
  "https://www.upcharcare.com",
  "http://localhost:5173",
  "http://localhost:3000",
];
const allowedOrigins = process.env.ALLOWED_ORIGINS
  ? process.env.ALLOWED_ORIGINS.split(",").map((o) => o.trim())
  : defaultOrigins;

app.use(
  cors({
    origin(origin, callback) {
      if (!origin || allowedOrigins.includes(origin)) {
        callback(null, true);
      } else {
        callback(new Error(`Origin ${origin} not allowed by CORS`));
      }
    },
  })
);
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
  console.log(`CORS allowed origins: ${allowedOrigins.join(", ")}`);
});
