variable "flavor_name" {
  type = string
  default = "d2-2"
}

variable "region" {
  type = string
  default = "GRA11"
}

variable "ext_net" {
  type = string
  default = "Ext-Net"
}

variable "image_name" {
  type = string
  default = "Ubuntu 22.04"
}

variable "public_subnet_cidr" {
  type = string
  default = "192.168.200.0/24"
}

variable "public_subnet_gateway_ip" {
  type = string
  default = "192.168.200.12"
}

variable "private_subnet_cidr" {
  type = string
  default = "192.168.199.0/24"
}

variable "private_subnet_gateway_ip" {
  type = string
  default = "192.168.199.12"
}