variable "region" {
  type        = string
  description = "The one region DeployHub uses."
  default     = "us-east-1"
}

variable "project" {
  type    = string
  default = "deployhub"
}

variable "owner" {
  type        = string
  description = "Value for the Owner tag (your name or handle)."
}

variable "alert_emails" {
  type        = list(string)
  description = "Budget alert recipients."
}

variable "monthly_budget_usd" {
  type    = number
  default = 5
}

variable "github_repo" {
  type        = string
  description = "owner/repo that hosts this project, e.g. alice/deployhub."
}
