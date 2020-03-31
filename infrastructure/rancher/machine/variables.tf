variable "key_pair" {
  type = object({
    key_name : string
    public_key : string
  })
}
variable "name" {
  default = "server"
}
variable "availability_zone" {
  default = "eu-de-01"
}
variable "flavor" {}
variable "image" {}
variable "eip" { default = "" }
variable "network" {}
variable "subnet" {}
variable "router" {}
variable "volume" {
  type    = number
  default = 10
}

variable "bastion_local_ip" { default = "" }
