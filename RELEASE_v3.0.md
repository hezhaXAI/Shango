# SH BUSINESS OS — Consolidated Engineering Release v3.0

## Included foundations
- Owner authentication foundation and role baseline
- Currency-separated accounting, chart of accounts, journal drafts/posting/reversal, periods and trial-balance endpoint
- Opening-balance reconciliation
- General capital partners, separate partner loans and repayments
- Controlled draft-journal links for partner capital and loan events
- Deal-specific real-estate participants with independent contribution, legal-ownership and profit-share fields
- Fuel, gold and silver trade register
- External company investments and periodic income register
- Warehouse item master and stock movement register
- Cash/bank movement register
- Audit event foundation, Docker Compose and environment template

## Verification performed for this package
- Python compileall: passed
- Existing automated unit tests: 13 passed
- SQLAlchemy model metadata creation on temporary SQLite: 24 tables created; all six v3.0 tables present
- PostgreSQL integration, complete API boot, browser UI, iPhone/PC demo acceptance and production deployment: not performed

## Remaining gates
Only the two major rollout gates remain in the project plan: (1) demo and end-to-end acceptance on iPhone and PC, and (2) managed private server provisioning and production hardening. Before live use, also complete the specific accounting/security controls described in `SECURITY_BASELINE.md` and `OPERATIONAL_MODULES_v3.0.md`.

## Known gaps / don't over-rely
The v3.0 operational registers are not all automatically journal-posted. Inventory valuation, batch/lot traceability, bank reconciliation, tax, payroll, full financial statements, property journal automation, MFA, password reset, session revocation, rate limiting, immutable audit and tested off-site restore are not complete. Treat this as a consolidated staging foundation, not a production ERP.

A legacy responsive Sorani RTL dark-luxury prototype is included in `demo/index.html` as a visual starting point. It is not wired to the new API; the demo integration/acceptance gate remains open.
