# SH BUSINESS OS v2.5 — Opening Balances & Capital Reconciliation

## What changed
- Fixed the ORM account model so it matches the v2.4 chart fields: `parent_id`, `normal_balance`, and `is_group`.
- Added a self-referencing account hierarchy and database constraints for normal balance and group accounts.
- Added `POST /opening-balances/validate`: validates a proposed opening-balance journal without saving it and returns debit/credit totals separately for USD and IQD.
- Added `GET /opening-balances/summary`: lists opening-balance drafts and posted entries with currency-separated totals.
- Added a same-date duplicate guard for opening-balance creation.
- Regular journal entries and opening balances reject posting lines to group accounts.
- Added blank CSV templates for entering proposed opening-balance lines and tracking supporting evidence.

## Important workflow
1. Establish the cut-off date for the opening balance.
2. Collect evidence for cash, bank, receivables, payables, loans, inventory, property, metals, external investments, and equity.
3. Reconcile each asset/liability/equity figure to source documents.
4. Map each line to a posting-enabled account code and its actual currency.
5. Validate the proposed lines using `POST /opening-balances/validate`.
6. If validation succeeds, create a draft using `POST /opening-balances`.
7. Review the draft and post it using the existing `POST /journal-entries/{entry_id}/post` endpoint.

## Accounting safeguards
- USD and IQD are balanced independently. They are never silently converted or netted against one another.
- No balances are pre-filled with invented amounts. Template example rows have blank amounts and are illustrative only.
- Contributions, loans, and deal-specific co-investor funds must be classified according to the actual agreement; do not infer equity, legal ownership, or profit share from cash contribution percentages.
- The opening-balance clearing account is not an automatic plug. Any difference must be investigated and deliberately classified before posting.
- Group accounts cannot receive journal lines; use leaf/posting accounts.
- Same-date opening-balance duplicates are blocked while an earlier entry is draft or posted.

## Migration
For an existing PostgreSQL database, take and verify a backup first. Review and apply `migrations/0003_chart_fields_safe_upgrade.sql`. Do not assume `Base.metadata.create_all()` upgrades existing tables; it does not add missing columns to existing tables.

## Status and limitations
This is an engineering foundation, not a production deployment. Python syntax compilation and unit tests are run as part of this package build. No live PostgreSQL integration test, production deployment, external security audit, or accounting sign-off is claimed. CSV templates are blank data-entry aids; CSV upload/import automation is not included in this version.
