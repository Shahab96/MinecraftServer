terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.28.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.18.0"
    } 
    linode = {
      source = "linode/linode"
      version = "1.28.0"
    }
  }
}

provider "cloudflare" {}

provider "linode" {}

provider "google" {
  project = var.project
  region = "us-central1"
}

resource "google_project_service" "dns" {
  service = "dns.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }
}