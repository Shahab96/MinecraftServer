resource "linode_sshkey" "this" {
  label = "SSH Public Key"
  ssh_key = chomp(file("../../id_rsa.pub"))
}

resource "linode_instance" "this" {
  image = "linode/ubuntu22.04"
  region = "us-east"
  type = "g7-highmem-1"
  authorized_keys = [linode_sshkey.this.ssh_key]
  booted = true
}