terraform {
  backend "s3" {
    bucket         = "terraform-bucket-landing-2025-04-22"
    key            = "glue-jobs/terraform.tfstate"
    region         = "us-east-1"
  }
}
