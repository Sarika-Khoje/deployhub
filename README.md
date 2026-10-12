# DeployHub

A mini PaaS on AWS: give it a GitHub repo, it builds, deploys, monitors, and rolls back the app.
Status: **Phase 0 (foundation) complete.** See `docs/` for ADRs and runbooks.

```
infra/bootstrap   remote state, budgets, GitHub OIDC role (local state, applied once)
infra/envs/dev    the platform (remote state)
infra/modules     tfstate, budget, github-oidc
docs/             ADRs, runbooks
.github/          CI: fmt, validate, tflint, read-only plan
```

Setup: `docs/00-account-setup.md`. Local checks: `make check validate lint`.
