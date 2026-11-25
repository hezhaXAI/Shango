# Security baseline — staging only

Implemented in this foundation:
- Owner bootstrap from environment variables
- Argon2 password hashing
- Short-lived signed JWT access tokens
- Authenticated account and journal endpoints
- API bound to localhost in Compose; PostgreSQL is private to the Docker network
- Positive journal amounts and currency allow-list
- Debit/Credit balance validation per currency

Required before production:
- TOTP MFA and recovery codes
- Login rate limiting, lockout policy, password reset, token/session revocation
- HTTPS reverse proxy and HSTS
- Secrets manager; rotate all initial credentials
- Database least-privilege roles and network restrictions
- Immutable audit log and approval workflow
- Encrypted off-site backups and restore drills
- Dependency/container scanning, patch process, monitoring and alerting
- Independent penetration test and accounting acceptance test

Never commit `.env` or production secrets to source control.
