# ADR 0001: Terraform remote state in S3 with DynamoDB locking

Status: accepted (Phase 0)

## Context
Terraform state must survive laptop loss, be lockable (CI and a human can both run), and cost nothing.

## Decision
S3 bucket (versioned, SSE-S3, public access blocked, TLS-only) plus a DynamoDB table (provisioned 5/5, inside the always-free 25 RCU/WCU). A separate `bootstrap` stack with local state creates them; every other stack uses a partial `backend "s3" {}` block configured by `backend.hcl` or CI flags.

## Alternatives
- S3-native locking (`use_lockfile`, newer Terraform): fewer resources, a valid future migration. We use DynamoDB first because it is the widely recognized pattern and the project brief asks for it.
- Terraform Cloud: free tier exists but adds an external dependency and hides the AWS plumbing we want to learn.
- SSE-KMS: better audit trail, but per-request and key costs.

## Consequences
The bootstrap stack's local state file is the one thing to back up by hand. Old state versions expire after 30 days.
