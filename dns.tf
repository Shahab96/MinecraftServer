data "google_dns_managed_zone" "this" {
  name = "dogar-dev"
}

resource "google_dns_record_set" "this" {
  name = "atm6.${data.google_dns_managed_zone.this.dns_name}"
  type = "A"
  ttl  = 60

  managed_zone = data.google_dns_managed_zone.this.name

  rrdatas = [linode_instance.this.ip_address]
}
