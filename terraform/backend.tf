terraform {
  cloud {
    organization = "ProjectsTerraform2025"

    workspaces {
      name = "s3-module-dev"
    }

    execution_mode = "local"
  }
}
