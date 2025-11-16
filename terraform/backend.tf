terraform {
  cloud {
    organization = "ProjectsTerraform2025"

    workspaces {
      name = "lambda-module-dev"
    }
  }
}
