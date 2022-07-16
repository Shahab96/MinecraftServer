terraform {
  required_providers {
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
