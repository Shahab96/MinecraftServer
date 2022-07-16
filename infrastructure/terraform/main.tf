terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.27.0"
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

provider "google" {
  project = var.project
  region = var.region
  zone = var.gcp_zone
}

provider "cloudflare" {
}

provider "linode" {}
