resource "cloudflare_record" "this" {
  zone_id = var.zone_id
  name = "atm6.shahab96.com"
  value = linode_instance.this.ip_address
  type = "A"
  ttl = 60
}