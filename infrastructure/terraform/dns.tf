resource "cloudflare_record" "this" {
  zone_id = var.zone_id
  name = "atm6.shahab96.com"
  value = google_compute_instance.this.network_interface.0.access_config.0.nat_ip
  type = "A"
  ttl = 3600
}