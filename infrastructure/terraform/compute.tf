resource "google_compute_address" "this" {
  name = "public-ip-address"
  network_tier = "STANDARD"
}

resource "google_compute_instance" "this" {
  name = "minecraft-server"
  machine_type = "n1-standard-2"
  allow_stopping_for_update = true
  tags = ["minecraft"]

  labels = {
    "env" = "minecraft"
  }

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

module "agent_policy" {
  source     = "terraform-google-modules/cloud-operations/google//modules/agent-policy"
  version    = "0.2.3"

  project_id = var.project
  policy_id  = "ops-agent"
  agent_rules = [
    {
      type               = "ops-agent"
      version            = "current-major"
      package_state      = "installed"
      enable_autoupgrade = true
    },
  ]
  group_labels = [
    {
      env = "minecraft"
    }
  ]
  os_types = [
    {
      short_name = "ubuntu"
    }
  ]
}