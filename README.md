# Apna Aspatal — Backend (Node/Express + Supabase)

Handles everything Supabase Auth doesn't do on its own: hospital
registration + approval, and managing doctors/treatments/beds for each
hospital. Login/signup (phone OTP) needs NO code here — that's entirely
Supabase Auth, called directly from the apps.

## How this fits with the rest of the project

- **apna-aspatal-app** (the React Native patient app) reads hospitals
  directly from Supabase (or eventually via `GET /api/hospitals`), and
  authenticates directly against Supabase Auth.
- **This backend** is where hospital staff and platform admins go
  through to register hospitals, manage their doctors/treatments/beds,
  and approve new hospitals — anything that needs privileged writes or a
  multi-step workflow, not simple reads.
- Both talk to the **same** Supabase Postgres database.

## Setup

```bash
npm install
cp .env.example .env
# then fill in .env with your real Supabase project URL and
# SERVICE ROLE key (Settings > API > service_role — NOT the anon key,
# this one bypasses RLS and must stay server-side only, never in the app)
```

**Run the schema first**, before starting the server: open your Supabase
project's SQL Editor and run the entire contents of `db/schema.sql`. This
creates all tables (hospitals, doctors, treatment_charges, bed_categories,
emergency_requests, profiles) plus Row Level Security policies.

```bash
npm run dev   # starts on http://localhost:4000 with auto-reload
```

## API overview

| Method | Path | Who |
|---|---|---|
| GET | `/api/hospitals` | public — approved hospitals only |
| GET | `/api/hospitals/:id` | public — full detail incl. doctors/treatments/beds |
| POST | `/api/hospitals` | any signed-in user — registers a hospital as "pending" |
| PATCH | `/api/hospitals/:id` | that hospital's staff, or admin |
| GET / POST | `/api/hospitals/:id/doctors` | public read / staff write |
| PATCH / DELETE | `/api/doctors/:id` | that hospital's staff, or admin |
| GET / POST | `/api/hospitals/:id/treatments` | public read / staff write |
| GET / PUT | `/api/hospitals/:id/beds/:type` | public read / staff write (upsert) |
| GET | `/api/admin/hospitals/pending` | admin only |
| POST | `/api/admin/hospitals/:id/approve` \| `/reject` | admin only |

Every write route expects `Authorization: Bearer <supabase access token>`
— the same token your RN app gets back from `supabase.auth.getSession()`
after phone OTP login.

## First-time setup you'll need to do manually in Supabase

1. Run `db/schema.sql`.
2. Manually promote your own account to `admin` once, so you can approve
   the first hospitals: in the SQL editor, run
   `update profiles set role = 'admin' where id = 'YOUR_USER_ID';`
   (find your user id in Authentication > Users).
3. Everything else (hospital_staff role, hospital_id linking) happens
   automatically through the API — `POST /api/hospitals` handles it.

## Suggested next steps

1. Get this running locally, register a test hospital through the API,
   approve it via your admin account, confirm it shows up in
   `GET /api/hospitals`.
2. Replace `src/data/mockHospitals.ts` and `mockHospitalDetails.ts` in
   the RN app with real calls to this API (or directly to Supabase).
3. Deploy this backend somewhere small and cheap — Railway or Render
   both work well for an always-on Node service like this.
4. Build the dispatch-matching logic on top of `emergency_requests` +
   PostGIS — that's the next major piece after this registration/CRUD
   layer is solid.
