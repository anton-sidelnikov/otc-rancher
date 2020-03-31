resource "random_string" "random_name" {
  length = 6
  special = false
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

resource "opentelekomcloud_vpc_v1" "vpc_v1" {
  name = "${random_string.random_name.result}"
  cidr = var.vpc_cidr
}
