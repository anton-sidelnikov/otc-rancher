
locals {
  workspace_prefix = terraform.workspace == "default" ? "" : "${terraform.workspace}-"
  key_pair = {
    public_key = var.public_key
    key_name   = "${local.workspace_prefix}${var.prefix}_kp"
  }
}

module "network" {
  source = "./network"

  addr_3_octets = var.addr_3_octets
  prefix        = "${local.workspace_prefix}${var.prefix}"
}

resource "opentelekomcloud_networking_floatingip_v2" "server_public_ip" {}

module "server" {
  source = "./machine"

  image  = var.image_name
  flavor = var.flavor

  key_pair = local.key_pair
  network  = module.network.network
  subnet   = module.network.subnet
  router   = module.network.router
  name     = "${local.workspace_prefix}${var.prefix}_server"

  availability_zone = var.availability_zone
  eip               = opentelekomcloud_networking_floatingip_v2.server_public_ip.address
}

output "server_fip" {
  value = opentelekomcloud_networking_floatingip_v2.server_public_ip.address
}