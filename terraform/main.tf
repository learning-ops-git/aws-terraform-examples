module "lambda_function" {
  source = "github.com/learning-ops-git/terraform-modules//module/lambda-mod?ref=lambda-mod"

  function_name = var.function_name
  filename      = local.filename
  handler       = var.handler
  runtime       = var.runtime
  timeout       = var.timeout
  memory_size   = var.memory_size
  environment_variables = var.environment_variables
  tags = var.tags
  log_retention_in_days = var.log_retention_in_days
  policy_arns  = var.policy_arns
}