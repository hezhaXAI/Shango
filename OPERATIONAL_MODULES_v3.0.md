# SH BUSINESS OS v3.0 — Consolidated operational modules

This release consolidates the existing accounting, capital/partner, partner-loan, real-estate, and source-journal foundations, and adds operational APIs for fuel/gold/silver trades, external investments and recurring income, warehouse items and stock movements, and cash/bank movements.

## Added APIs
- `POST/GET /commodity-trades`: fuel, gold, silver purchase/sale records with quantity, unit, unit price, currency, counterparty and extra costs.
- `POST/GET /external-investments`: company investment register and same-currency income summaries.
- `POST /external-investments/{id}/income`: monthly/periodic income record. Income currency must match the investment currency.
- `POST/GET /inventory/items`: stock item master and on-hand quantity summary.
- `POST /inventory/movements`: stock in/out/positive adjustment; stock-out cannot exceed available quantity.
- `POST/GET /cash-bank/movements`: cash/bank movement register with account and currency validation.

## Important functional boundaries
- These new operational registers are not yet automatically journal-posted. Cash/bank movements return `journal_status=not_posted`; use the accounting workflow only after explicit account mapping and owner approval are implemented for each source.
- Commodity trade records calculate gross value and cost/proceeds for display but do not yet implement FIFO/weighted-average inventory valuation, batch/lot tracking, fuel temperature/density conversion, assay/purity, or automatic COGS.
- Inventory movements use quantities and optional unit cost; weighted average/FIFO costing and warehouse locations are not yet implemented. `adjustment` currently increases stock; use a controlled compensating out movement for decreases.
- External investment returns are recorded as income, not automatically classified as dividends, interest, or capital return.
- Property accounting automation, full customer/supplier subledgers, tax, payroll, bank reconciliation, and financial statement close are not complete.
- Existing version limitations remain: MFA, password reset, session revocation, rate limiting, immutable audit, full Alembic chain, production restore test and independent security review remain required.

## Migration
Apply `migrations/0007_operational_modules.sql` after backup and after reviewing the existing schema. The app startup `create_all` is a development convenience, not a production migration strategy.
