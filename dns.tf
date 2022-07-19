data "google_dns_managed_zone" "this" {
  name = "dogar-dev"
}

resource "cloudflare_record" "this" {
  zone_id = var.zone_id
  name = "atm6.shahab96.com"
  value = linode_instance.this.ip_address
  type = "A"
  ttl = 60
}

resource "google_dns_record_set" "this" {
  name = "atm6.${data.google_dns_managed_zone.this.dns_name}"
  type = "A"
  ttl  = 60

  managed_zone = data.google_dns_managed_zone.this.name

  rrdatas = [linode_instance.this.ip_address]
}
