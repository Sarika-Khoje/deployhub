# Phase 0 runbook: account safety and bootstrap

All steps are manual or CLI. Do them in order. Never skip step 1.

## 1. Lock down the account (console, ~15 min)
1. Root user: enable MFA, delete any root access keys, use root only for billing/account settings.
2. Create an admin IAM user (e.g. `deployhub-admin`) in an `Admins` group with `AdministratorAccess`, enable MFA on it, and use it for everything else.
   - Use plain IAM users, NOT IAM Identity Center, for now: Identity Center needs AWS Organizations, and on the Free plan joining an Organization upgrades you to Paid and expires your credits immediately.
3. Billing > Billing preferences: turn on Free Tier usage alerts and billing alert emails.
4. Pick ONE region (default `us-east-1`) and use it everywhere.
5. Confirm your plan: Billing and Cost Management > Account plan (Free or Paid).

## 2. Local CLI auth
```
# Create an access key for the IAM admin user (console > IAM > Users > Security credentials), then:
aws configure --profile deployhub
export AWS_PROFILE=deployhub
aws sts get-caller-identity
```
Keys for the IAM user live only in `~/.aws/credentials`. Rotate them when the project ends.

## 3. Bootstrap (local state, run once)
```
cd infra/bootstrap
cp terraform.tfvars.example terraform.tfvars   # edit it
terraform init && terraform plan -out tfplan && terraform apply tfplan
terraform output backend_hcl                    # copy this
```
Budget alerts go straight to the emails you listed (no confirmation step); check your spam folder if one ever fires.

## 4. Platform root with remote state
```
cd ../envs/dev
cp backend.hcl.example backend.hcl              # paste values from step 3
cp terraform.tfvars.example terraform.tfvars
terraform init -backend-config=backend.hcl
terraform plan && terraform apply
terraform destroy                                # proves the clean-teardown path
```

## 5. GitHub Actions
Repo > Settings > Secrets and variables > Actions > Variables:
`AWS_ROLE_ARN` (from `terraform output ci_plan_role_arn`), `AWS_REGION`, `TF_STATE_BUCKET`, `TF_LOCK_TABLE`.
No secrets are needed: auth is OIDC.

## Teardown of bootstrap (end of project only)
The state bucket has `prevent_destroy`. Remove that lifecycle block, empty the bucket (all versions), then `terraform destroy` in `infra/bootstrap`.
