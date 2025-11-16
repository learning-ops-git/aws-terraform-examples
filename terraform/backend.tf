terraform {
  backend "s3" {
    bucket = "co-data-engineering-216461881627-dev-artifacts"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"

    # Optional: Encrypt state file
    encrypt = true
  }
}