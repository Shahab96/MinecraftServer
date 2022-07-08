resource "google_compute_instance" "this" {
  name = "minecraft-server"
  machine_type = "n1-standard-2"
  allow_stopping_for_update = true
  tags = ["minecraft"]

  advanced_machine_features {
    threads_per_core = 1
  }

  network_interface {
    network = "default"
    
    access_config {
      # Added only to ensure a network interface is created.
      network_tier = "STANDARD"
    }
  }

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size = 20
    }
  }
}

resource "google_compute_firewall" "this" {
  name = "minecraft-firewall-rules"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["22", "25565"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["minecraft"]
}
