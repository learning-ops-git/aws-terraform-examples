variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "handler" {
  description = "Function entrypoint in the code"
  type        = string
  default     = "lambda_handler.main"
}

variable "runtime" {
  description = "Lambda runtime environment"
  type        = string
  validation {
    condition     = contains(["python3.8", "python3.9", "python3.10", "python3.11"], var.runtime)
    error_message = "Runtime must be one of: python3.8, python3.9, python3.10, python3.11"
  }
  default     = "python3.11"
}

variable "timeout" {
  description = "Lambda function timeout in seconds"
  type        = number
  default     = 10
}

variable "memory_size" {
  description = "Amount of memory in MB for Lambda function"
  type        = number
  default     = 128
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "log_retention_in_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 7
}

# SIMPLE POLICY CONFIGURATION
variable "policy_arns" {
  description = "List of IAM policy ARNs to attach to the Lambda role"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
}