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
    linode = {
      source  = "linode/linode"
      version = "1.28.0"
    }
  }
}

provider "linode" {}

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
