resource "google_compute_address" "this" {
  name = "public-ip-address"
  network_tier = "STANDARD"
}

resource "google_compute_instance" "this" {
  name = "minecraft-server"
  machine_type = "n1-standard-2"
  allow_stopping_for_update = true
  tags = ["minecraft"]

  metadata = {
    ssh-keys = "shahab96:${file("../../id_rsa.pub")}"
  }

  advanced_machine_features {
    threads_per_core = 1
  }

  network_interface {
    network = "default"
    
    access_config {
      network_tier = "STANDARD"
      nat_ip = google_compute_address.this.address
    }
  }

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size = 20
    }
  }
}

resource "google_compute_firewall" "this" {
  name = "minecraft-firewall-rules"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["25565"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["minecraft"]
}

resource "google_os_login_ssh_public_key" "this" {
  user =  data.google_client_openid_userinfo.me.email
  key = file("../../id_rsa.pub")
}