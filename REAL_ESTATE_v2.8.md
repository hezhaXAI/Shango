# SH BUSINESS OS v2.8 — Real Estate Management

## Scope
- One record per property deal with code, location, area, purchase amount/date, currency and title-document reference.
- Deal-specific participants: owner/general business capital and outside co-investors are represented as participants in this deal. An optional link to a general partner record reuses identity only; it does not make the deal participant a general capital partner in this deal.
- Three independent participant fields: cash contribution, legal ownership percentage, and profit-sharing percentage. Percentages are never inferred from contributions or copied from another deal.
- Deal expenses and one sale record per deal, including amount received and outstanding receivable.
- Installment ledger for participant contributions, purchase payments and sale receipts, with caps against agreed contribution, purchase price and sale amount.
- Deal report shows purchase price, expenses, sale proceeds, net result and allocations using only explicitly entered profit-share percentages.
- USD and IQD are kept separate; each deal uses one currency and related contributions/expenses/sale must match it.

## API
- `POST /properties`, `GET /properties`
- `POST /properties/{deal_id}/participants`, `GET /properties/{deal_id}/participants`
- `POST /properties/{deal_id}/expenses`
- `POST /properties/{deal_id}/payments`, `GET /properties/{deal_id}/payments`
- `POST /properties/{deal_id}/sale`
- `GET /properties/{deal_id}/report`

## Important controls and limitations
- Apply `migrations/0006_real_estate.sql` after a verified database backup.
- A deal may be closed as sold once; sale received amount cannot exceed sale price.
- Legal ownership and profit-sharing totals are reported as configured/not configured to 100%; the system does not silently normalize percentages.
- Current net result is a simple deal-level calculation: sale amount less purchase price and recorded expenses, in the deal currency. It does not yet include financing cost, taxes, FX gain/loss, commissions, or accounting journal posting.
- Participant contribution commitments are stored per participant; dated installment records track paid amounts. Purchase partial payments and sale receipts are also tracked. A participant installment cannot exceed the entered contribution commitment.
- No general-ledger postings are generated automatically for property transactions in v2.8.
- Legal title must be checked against official contracts/title records; software percentages are not legal advice or proof of title.

## Verification
This is an engineering increment, not a production deployment. Run unit tests, database migration tests against PostgreSQL, authorization tests, and financial acceptance tests before live use.
