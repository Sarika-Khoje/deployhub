# ADR 0002: Account guardrails and CI identity

Status: accepted (Phase 0)

## Decisions
- No root usage after setup; one MFA-protected IAM admin user for human work. IAM Identity Center is deferred because it requires AWS Organizations, which upgrades a Free-plan account to Paid and expires its credits.
- Budgets alert on gross spend (credits excluded) so credits cannot mask real usage.
- GitHub Actions uses OIDC, not access keys. The trust policy is pinned to one repo and to `pull_request` and `main` only.
- The CI role is read-only (`ReadOnlyAccess` plus state read) and plans with `-lock=false`. `apply` stays manual in Phase 0; a scoped apply role arrives with Phase 6.
- Everything is tagged through provider `default_tags`: Project, Environment, ManagedBy, Owner.

## Trade-off
A read-only plan cannot take the state lock, so two simultaneous CI plans could read slightly stale state. Acceptable because plans never write.
