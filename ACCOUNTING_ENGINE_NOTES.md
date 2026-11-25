# Central Accounting Engine 2.3

Implemented in this increment:
- Accounting periods with date boundaries and close control.
- Journal entries start as drafts.
- Posting validates per-currency double-entry balance.
- Posted entries cannot be edited through the API.
- Reversal creates a counter-entry and marks original as reversed.
- Basic audit events for account creation, period creation/close, journal draft, posting and reversal.
- Trial Balance report from posted/reversed entries.

Important limitations still open:
- MFA is not implemented.
- Audit log is not yet tamper-evident/append-only at the database permission layer.
- Approval workflow currently assumes one Owner and posts via an authenticated Owner account; dual control is not implemented.
- No idempotency keys, concurrency controls, period-close locking, account hierarchy, opening balances, sub-ledgers, tax, bank reconciliation, or full financial statements yet.
- Currency conversion entries and realized/unrealized FX are not yet implemented.
- Startup schema creation is development-only; production requires Alembic migrations.
- Automated tests are supplied but have not been executed in this environment.
