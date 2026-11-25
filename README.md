# SH BUSINESS OS 2.3 — Managed Server Backend Foundation

This package is the next engineering foundation for SH BUSINESS OS. It adds a FastAPI backend, PostgreSQL, Docker Compose, owner login, chart of accounts, and balanced journal posting.

## Important status
This is a **development/staging foundation**, not a production-certified ERP. Do not enter live financial records until deployment hardening, independent security review, backups/restore testing, accounting acceptance tests, and operational monitoring are completed.

## Stack
- FastAPI + Python
- PostgreSQL
- SQLAlchemy
- Argon2 password hashing
- JWT access tokens
- Docker Compose for local/staging deployment

## Start locally
1. Copy `.env.example` to `.env`.
2. Replace every placeholder, especially `JWT_SECRET` and `OWNER_PASSWORD`.
3. Run `docker compose up --build`.
4. API docs: `http://localhost:8000/docs`
5. Health: `http://localhost:8000/health`

The first run creates the Owner account from `OWNER_EMAIL` and `OWNER_PASSWORD`. Change the password immediately after first login. Do not expose the API publicly until HTTPS, MFA, rate limiting, firewall rules, secrets management, and monitoring are configured.

## Main API
- `POST /auth/login`
- `GET /auth/me`
- `GET /accounts`
- `POST /accounts`
- `GET /journal-entries`
- `POST /journal-entries`

Journal posting validates that debit and credit totals match **separately for each currency**. USD and IQD are never added together. FX conversions must be explicit and recorded separately.

## Managed Server deployment
A managed VPS/container host can run this Docker Compose stack, but provider selection and production deployment are not included. Keep PostgreSQL private; only expose the HTTPS reverse proxy/API. Use a managed database or private database network, encrypted backups, and tested restore procedures.

## Next milestones
1. Choose provider and region; configure managed server and domain later.
2. Add MFA (TOTP), rate limiting, session revocation, and secure password reset.
3. Add accounting periods, approval workflow, reversals, immutable audit events, and idempotency.
4. Complete modules: Real Estate deal partnerships, Fuel, Metals, External Investments, Capital/Loans, Bank & Cash.
5. Add automated tests and accounting reconciliation.
6. Deploy to staging, test on iPhone and PC, then production after sign-off.

## Version 2.4 additions
- Hierarchical chart of accounts and account groups.
- Standard starter chart seeded at startup for development.
- Opening balance draft endpoint; all balances still require normal posting.


## v2.5 update
See `OPENING_BALANCES_RECONCILIATION_v2.5.md` for reconciliation workflow, new validation/summary endpoints, safe migration, and CSV templates. This remains a development foundation, not a deployed production system.


## v2.6 update
See `CAPITAL_PARTNERS_v2.6.md` for the general partner register, separate equity contribution/withdrawal ledger, partner loan register and repayment tracking. Apply `migrations/0004_capital_partners.sql` after a verified backup. The operational ledgers do not yet auto-post general-ledger journals.


## v2.7 — Accounting Integration
See `ACCOUNTING_INTEGRATION_v2.7.md`. This version adds owner-initiated draft journal links for capital contributions/withdrawals, partner loan receipts, and principal repayments. Drafts require explicit account selection, same-currency balancing, an open accounting period, and duplicate-source protection. No automatic posting is performed.

## v2.8 — Real Estate Management
Adds deal-specific property records, multiple deal participants, independent legal ownership and profit-share percentages, contribution commitments and installment payments, purchase installments, expenses, sale proceeds/receivables and sale-receipt installments, plus a deal report. See `REAL_ESTATE_v2.8.md` and apply `migrations/0006_real_estate.sql` after backup. No automatic property journal posting or installment-level contribution schedule is included yet.

## v3.0 — Consolidated business operations
This release adds operational registers for fuel/gold/silver trading, external company investments and periodic income, inventory items and stock movements, and cash/bank movements. See `OPERATIONAL_MODULES_v3.0.md` and migration `0007_operational_modules.sql`.

## Remaining before live use
The engineering package is consolidated, but it is not production-ready. The next two practical gates are:
1. **Demo / acceptance test:** run the full workflows with sample data on iPhone and PC, verify reports, currency separation, property deal agreements, inventory balances, and accounting reconciliation.
2. **Managed private server:** select and provision the server, configure domain/HTTPS/firewall/secrets/MFA/monitoring/encrypted off-site backups, apply reviewed migrations, test restore, and complete an independent security review.

Do not use this package as the sole record system for live money until both gates and accounting/security sign-off are complete.

## Demo shell
A responsive Sorani RTL dark-luxury prototype is included at `demo/index.html`. It is a visual/localStorage prototype only and is **not connected** to the v3.0 API yet. Use it for design review only; do not enter live financial data. The demo acceptance phase must connect all screens to the authenticated API and test on iPhone and PC.
