output "state_bucket" {
  value = module.tfstate.bucket_name
}

output "lock_table" {
  value = module.tfstate.lock_table_name
}

output "ci_plan_role_arn" {
  value = module.github_oidc.plan_role_arn
}

output "backend_hcl" {
  description = "Paste into infra/envs/dev/backend.hcl"
  value       = <<-EOT
    bucket         = "${module.tfstate.bucket_name}"
    key            = "envs/dev/terraform.tfstate"
    region         = "${var.region}"
    dynamodb_table = "${module.tfstate.lock_table_name}"
    encrypt        = true
  EOT
}
