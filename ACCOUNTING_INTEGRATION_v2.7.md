# SH BUSINESS OS — Accounting Integration v2.7

## Scope
This release adds controlled links between partner capital/loan source events and the central journal ledger. It creates **draft** journal entries only; it never posts automatically.

## New endpoints
All endpoints require owner authentication:

- `POST /capital-transactions/{transaction_id}/journal-draft`
- `POST /partner-loans/{loan_id}/journal-draft`
- `POST /partner-loan-payments/{payment_id}/journal-draft`

Request body for each endpoint:

```json
{
  "cash_account_id": 12,
  "offset_account_id": 34
}
```

The account IDs are examples only. The owner must select actual active accounts from the chart of accounts. No account IDs are hard-coded.

## Posting logic

| Source event | Debit | Credit |
|---|---|---|
| Partner capital contribution | Cash/bank asset | Partner capital/equity |
| Partner capital withdrawal | Partner capital/equity | Cash/bank asset |
| Loan principal received | Cash/bank asset | Loan payable/liability |
| Loan principal repayment | Loan payable/liability | Cash/bank asset |

Each journal has two lines in the source transaction's currency. USD and IQD are never netted or converted as part of this workflow. Account currency restrictions are checked. Group accounts and inactive accounts are rejected.

## Duplicate prevention and review

- `journal_source_links` links each source event to at most one journal entry.
- A unique constraint on `(source_type, source_id)` prevents duplicate drafts for the same source event.
- A unique constraint on `journal_entry_id` prevents one journal from being linked to multiple source events.
- A draft requires an open accounting period covering the source event date.
- Owner review and the existing `/journal-entries/{id}/post` action are still required to post.
- Reversal remains handled through the existing journal reversal workflow; source events are not silently rewritten.

## Important limitations

- This release does not automatically generate journals when source events are first created. The owner explicitly invokes the journal-draft endpoint after choosing the correct accounts.
- The selected offset account is not automatically partner-specific; the chart may use a shared equity/liability control account. Partner-level detail remains in the partner subledger.
- Loan repayments are principal-only. Interest accruals, interest payments, and amortization schedules are not implemented.
- The source link is immutable through the current API; correction is by controlled journal reversal and a separately reviewed correction workflow.
- Database-level concurrency and PostgreSQL integration tests have not been run in this environment. The unique constraint is the final duplicate guard in PostgreSQL, but API-level handling of a concurrent uniqueness race still needs a production-hardening pass.
- No production deployment, managed server provisioning, MFA completion, or independent security review is claimed.

## Migration
Apply `migrations/0005_accounting_source_links.sql` after migrations 0001–0004. The SQLAlchemy model also defines the table for development `create_all`; production should use reviewed migrations only.
