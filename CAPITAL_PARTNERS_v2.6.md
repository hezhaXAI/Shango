# SH BUSINESS OS v2.6 — Capital & Partners Management

## Scope
This module records general business capital partners and loans received from them. It does not treat a deal-only property co-investor as a general capital partner unless the owner explicitly creates a separate general-partner record.

## Added
- Partner register: unique code, name, phone, notes, active status.
- Capital register: dated contributions and withdrawals, with currency, amount, reference and notes.
- Partner capital report: contributions, withdrawals and net capital balance per partner and currency.
- Partner loans: principal, currency, date, due date, indicative interest rate, status.
- Loan repayments: payments against principal, outstanding balance, automatic settled status when principal reaches zero.
- Audit events for partner, capital, loan and repayment creation.
- PostgreSQL migration `migrations/0004_capital_partners.sql`.

## API endpoints
- `POST /partners`, `GET /partners`
- `POST /capital-transactions`, `GET /capital-transactions?partner_id=`
- `GET /reports/partner-capital`
- `POST /partner-loans`, `GET /partner-loans?partner_id=`
- `POST /partner-loans/{loan_id}/payments`

All endpoints require owner login/JWT.

## Accounting rules
- Contributions and withdrawals are equity movements; loans and loan repayments are stored in separate loan tables.
- USD and IQD balances are kept separate; no automatic conversion or netting.
- A withdrawal cannot exceed that partner's recorded net contribution balance in the same currency.
- A loan repayment cannot exceed its remaining principal.
- No partner capital ownership percentage or profit-share percentage is inferred from cash contribution amounts.
- A property-deal investor is not automatically a general business partner.
- The module currently records operational ledgers and audit events; it does NOT automatically create/post general-ledger journal entries. Accounting integration and reconciliations are a later milestone.
- `interest_rate` is informational only in this version. Interest accrual/payment schedules and interest journal entries are not implemented.
- Records have no delete/edit endpoint by design; corrections should be handled by a controlled reversal/correction workflow in a later release.

## Migration and deployment
For an existing PostgreSQL database, back up and verify the backup first, then review and apply `migrations/0004_capital_partners.sql`. `create_all()` can create new tables in a fresh database but does not upgrade existing tables. No production deployment or live PostgreSQL integration test is claimed.
