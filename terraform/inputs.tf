variable "country" {
  description = "The country where the S3 bucket will be created."
  type        = string
  default     = "co"
  validation {
    condition     = contains(["co", "us", "cn"], var.country)
    error_message = "Country code must be one of: co, us, or cn"
  }
}

variable "domain" {
  description = "The domain associated with the S3 bucket."
  type        = string
  validation {
    condition     = length(var.domain) > 0
    error_message = "Domain cannot be an empty string"
  }
}

variable "environment" {
  description = "The environment for the S3 bucket."
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "prod", "test"], var.environment)
    error_message = "Environment must be one of: dev, prod, test"
  }
}

variable "owner" {
  description = "The owner of the S3 bucket."
  type        = string
  validation {
    condition     = length(var.owner) > 0
    error_message = "Owner cannot be an empty string"
  }
}

variable "tags" {
  description = "A map of tags to assign to the S3 bucket."
  type        = map(string)
  default     = {}
}