# Chart of Accounts Professional + Opening Balances — 2.4

Added:
- Hierarchical chart of accounts with parent/child codes.
- Group accounts vs posting accounts.
- Normal balance side (debit/credit).
- USD/IQD-specific cash and bank accounts.
- Initial account template for assets, liabilities, equity, revenue and expenses.
- Chart endpoint: GET /accounts/chart
- Opening balance draft endpoint: POST /opening-balances
- Opening balances are validated by currency and cannot be posted directly; they enter the same review/posting process as journals.

Important:
- Seeded chart is a starting template and must be reviewed and tailored before live use.
- Do not enter actual opening balances until bank/cash, receivables, payables, inventory, property, metals, loans and equity are reconciled to source documents.
- Opening balance counterpart account should be selected deliberately; the system does not guess whether a difference is owner equity, retained earnings, debt, or a partner liability.
- This is not yet production-ready. Run automated tests and staging database migrations before deployment.
