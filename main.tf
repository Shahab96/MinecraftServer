terraform {
  backend "gcs" {
    bucket = "terraform-state-fzaspcp1"
    prefix = "minecraft"
  }
  required_version = ">= 1.2.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.28.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.18.0"
    }
    linode = {
      source  = "linode/linode"
      version = "1.28.0"
    }
  }
}

provider "cloudflare" {
  email = "shahab96@gmail.com"
  api_key = "48ae3084929093c94c0eac47a45456ff0bafc"
}

provider "linode" {
  token = "7aa605fcf3af06372df55920e500ce01ed7b4ac31014be4ce6180cde854c189f"
}

provider "google" {
  project = data.terraform_remote_state.infra.outputs.projects.dogar
  region  = "us-central1"
}

data "terraform_remote_state" "infra" {
  backend = "gcs"

  config = {
    bucket = "terraform-state-fzaspcp1"
  }
}
