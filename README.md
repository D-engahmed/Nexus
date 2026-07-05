# Nexus

Multi-vendor food delivery platform — customer, merchant, driver, and admin experiences on a single backend. Currently scoped to a lean, single-city MVP with a documented path to a full microservices target state.

**Status:** 🚧 Pre-launch — MVP in active development. Backend not yet implemented; customer app running against contract-aligned mock data.

---

## Table of Contents

- [Current Status](#current-status)
- [Repository Structure](#repository-structure)
- [Tech Stack](#tech-stack)
- [MVP Scope](#mvp-scope)
- [Getting Started](#getting-started)
- [Documentation](#documentation)
- [Architecture Decisions](#architecture-decisions)
- [License](#license)

---

## Current Status

This table reflects what's actually implemented, not what's documented as planned. Update it as pieces land — a README that overstates progress is worse than no README.

| Component | Status | Notes |
| :--- | :--- | :--- |
| `platform/backend` | ⬜ Not started | No API endpoints exist yet. Customer app runs on local mock data as a stand-in. |
| `platform/frontend/customer-app` | 🟨 In progress | Flutter app scaffolded (Melos monorepo pattern). Browse, cart, checkout, order tracking, and profile screens built against mock data. |
| `platform/frontend/admin-portal` | ⬜ Not started | |
| `platform/frontend/driver-app` | ⬜ Not started | Explicitly out of MVP scope; contingent on a team hire (see [Lean MVP Plan](docs/07_Lean_MVP_Plan.md)). |
| Payment gateway | ⬜ Not started | MVP uses a simulated payment confirmation only. No live gateway (Paymob or otherwise) is integrated. |
| Database | ⬜ Not started | Schema documented in [Database Schema Overview](docs/Database_Schema_Overview.md); not yet provisioned. |

## Repository Structure

```
Nexus/
└── platform/
    ├── backend/                  # Node.js / TypeScript API (not yet implemented)
    └── frontend/
        ├── customer-app/         # Flutter — customer-facing mobile app
        ├── admin-portal/         # Web admin dashboard (not yet implemented)
        └── driver-app/           # Flutter — driver app (post-MVP, hire-contingent)
```

## Tech Stack

Two tables on purpose — conflating "what we've decided for target state" with "what MVP actually needs" is a documented anti-pattern on this project. Don't merge these back into one list.

### Currently implemented
| Layer | Choice |
| :--- | :--- |
| Mobile (customer) | Flutter, `provider` package for state management |
| Mock data | Contract-aligned to `API_Endpoints_Master_List.md`, so swapping to a live backend is a config change, not a rewrite |

### Documented target / planned
| Layer | Choice | Status |
| :--- | :--- | :--- |
| Backend API | Node.js (TypeScript) | Planned |
| Database | PostgreSQL | Planned — single instance for MVP, schema-per-bounded-context |
| Cache | Redis | **Unconfirmed** — not yet justified by a real load requirement; see open items below |
| Web frontend | React + Next.js | Planned |
| Async / events | pg-boss or BullMQ (MVP) → Kafka (target state) | MVP-scale queue only; Kafka/RabbitMQ are not interchangeable and should not be treated as such |
| Payments | Paymob (covers cards, wallets, and local methods incl. Vodafone Cash / Orange Cash for Egypt) | Planned — requires live backend + webhook handling first |

**Open items that should become ADRs, not stay as a floating table:** Redis's justification, and whether the MVP is being deliberately expanded to include a message broker now vs. at target state. See [Architecture Decisions](#architecture-decisions).

## MVP Scope

Full detail in [`07_Lean_MVP_Plan.md`](docs/07_Lean_MVP_Plan.md). Summary:

- **In scope:** one city, one merchant type, one payment method (simulated), customer signup/login/browse/checkout, merchant accept/reject, admin order visibility.
- **Explicitly out of scope:** driver app, real routing, loyalty/recommendations, full payment gateway integration, multi-vendor order consolidation.

If a feature request doesn't map to the in-scope list above, it's a scope decision, not a build task — flag it before writing code.

## Getting Started

### Customer app (Flutter)

```bash
cd platform/frontend/customer-app
flutter pub get
flutter run
```

**Windows note:** if you hit a Gradle/Kotlin incremental-cache locking failure on `flutter run`, stop the Gradle daemon, clean `build/` and `.gradle/` dirs, and exclude the project folder from Windows Defender real-time scanning before retrying.

### Backend

Not yet implemented — see [Current Status](#current-status).

## Documentation

The full SRS + SAD suite lives under `docs/`. Start here:

| Document | Purpose |
| :--- | :--- |
| [`01_Executive_Summary.md`](docs/01_Executive_Summary.md) | Business context and vision |
| [`07_Lean_MVP_Plan.md`](docs/07_Lean_MVP_Plan.md) | What's actually in scope right now |
| [`SAD_Master_Index.md`](docs/SAD_Master_Index.md) | Full target-state architecture |
| [`API_Endpoints_Master_List.md`](docs/API_Endpoints_Master_List.md) | API contract mock data is aligned to |
| [`Domain_Model_Bounded_Contexts.md`](docs/Domain_Model_Bounded_Contexts.md) | Domain boundaries |

## Architecture Decisions

Non-trivial architecture or stack choices go in [`03_Architecture_Decision_Records.md`](docs/03_Architecture_Decision_Records.md) as a formal ADR (Context / Decision / Rationale / Consequences / Alternatives) — not as a Slack message, a comment, or a table pasted into chat. If it's not written down with a rationale, treat it as undecided regardless of how many times it's been mentioned.

## License

Proprietary — All rights reserved. *(Confirm this is correct; no license file currently exists in this repo.)*

---

**Maintainer:** Ahmed Abdullah Mohamed