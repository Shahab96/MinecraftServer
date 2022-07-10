resource "linode_sshkey" "this" {
  label = "ATM6"
  ssh_key = chomp(file("../../id_rsa.pub"))
}

resource "linode_instance" "this" {
  label = "ATM6"
  image = "linode/ubuntu22.04"
  region = "us-east"
  type = "g7-highmem-1"
  authorized_keys = [linode_sshkey.this.ssh_key]
  booted = true
}

resource "linode_firewall" "this" {
  label = "ATM6"

  inbound {
    label = "Minecraft"
    action = "ACCEPT"
    protocol = "TCP"
    ports = "25565"
    ipv4 = [ "0.0.0.0/0" ]
  }

  inbound_policy = "DROP"
  outbound_policy = "ACCEPT"

  linodes = [ linode_instance.this.id ]
}