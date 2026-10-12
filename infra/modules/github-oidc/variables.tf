variable "project" {
  type = string
}

variable "github_repo" {
  type        = string
  description = "owner/repo allowed to assume the CI role."

  validation {
    condition     = can(regex("^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$", var.github_repo))
    error_message = "github_repo must look like owner/repo."
  }
}

variable "state_bucket_arn" {
  type = string
}
