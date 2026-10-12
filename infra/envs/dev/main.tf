data "aws_caller_identity" "current" {}

locals {
  tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
    Owner       = var.owner
  }
}

# Phase 0 placeholder: one free SSM Standard parameter proves the whole
# init -> plan -> apply -> destroy loop (remote state, locking, tags) end to end.
# Later phases add real modules here.
resource "aws_ssm_parameter" "platform_version" {
  name  = "/${var.project}/${var.environment}/platform_version"
  type  = "String"
  value = "phase-0"
}
