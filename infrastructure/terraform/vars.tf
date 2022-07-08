#------------------------
# Required variables
#------------------------
variable "project" {
  type = string
  description = "Your Google project ID"
}

variable "zone_id" {
  type = string
  description = "The zone ID in Cloudflare to deploy to"
}

#------------------------
# Configurable variables
#------------------------
variable "region" {
  type = string
  description = "The region in GCP to deploy to"
  default = "us-west1"
}