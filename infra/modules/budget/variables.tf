variable "project" {
  type = string
}

variable "monthly_limit_usd" {
  type        = number
  description = "Monthly gross-spend budget in USD."
}

variable "alert_emails" {
  type        = list(string)
  description = "Addresses that receive budget notifications."

  validation {
    condition     = length(var.alert_emails) > 0
    error_message = "Provide at least one alert email."
  }
}
