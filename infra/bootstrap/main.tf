data "aws_caller_identity" "current" {}

locals {
  tags = {
    Project     = var.project
    Environment = "shared"
    ManagedBy   = "terraform"
    Owner       = var.owner
    Stack       = "bootstrap"
  }
  state_bucket = "${var.project}-tfstate-${data.aws_caller_identity.current.account_id}-${var.region}"
  lock_table   = "${var.project}-tflock"
}

module "tfstate" {
  source          = "../modules/tfstate"
  bucket_name     = local.state_bucket
  lock_table_name = local.lock_table
}

module "budget" {
  source            = "../modules/budget"
  project           = var.project
  monthly_limit_usd = var.monthly_budget_usd
  alert_emails      = var.alert_emails
}

module "github_oidc" {
  source           = "../modules/github-oidc"
  project          = var.project
  github_repo      = var.github_repo
  state_bucket_arn = module.tfstate.bucket_arn
}
