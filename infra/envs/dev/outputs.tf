output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "platform_version_parameter" {
  value = aws_ssm_parameter.platform_version.name
}
