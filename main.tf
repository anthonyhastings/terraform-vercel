// Ensure that the `TF_VAR_VERCEL_API_TOKEN` environment variable is present.
variable "VERCEL_API_TOKEN" {
  type = string
  description = "API Token generated from Vercel UI"
  sensitive = true
}

terraform {
  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = "~> 0.4"
    }
  }
}

provider "vercel" {
  api_token = var.VERCEL_API_TOKEN
}

resource "vercel_project" "terraform-local-test" {
  name      = "terraform-local-test"
}

resource "vercel_project_environment_variable" "production_example" {
  project_id = vercel_project.terraform-local-test.id
  key        = "foo"
  value      = "bar-production"
  target     = ["production"]
}

resource "vercel_project_environment_variable" "preview_example" {
  project_id = vercel_project.terraform-local-test.id
  key        = "foo"
  value      = "bar-staging"
  target     = ["preview"]
}
