resource "openstack_networking_network_v2" "private_network" {
  name           = "private_network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "private_subnet" {
  name        = "private_subnet"
  network_id  = openstack_networking_network_v2.private_network.id
  cidr        = var.private_subnet_cidr
  ip_version  = 4
  enable_dhcp = true
  gateway_ip  = var.private_subnet_gateway_ip
}

resource "openstack_networking_subnet_v2" "public_subnet" {
  name            = "public_subnet"
  network_id      = openstack_networking_network_v2.private_network.id
  cidr            = var.public_subnet_cidr
  ip_version      = 4
  enable_dhcp     = true
  gateway_ip      = var.public_subnet_gateway_ip
  dns_nameservers = ["8.8.4.4"]
}

resource "openstack_networking_router_v2" "router" {
  name                = "router"
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.ext-net.id
}

resource "openstack_networking_router_interface_v2" "router_interface_private" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.private_subnet.id
}

resource "openstack_networking_router_interface_v2" "router_interface_public" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.public_subnet.id
}

resource "openstack_networking_floatingip_v2" "front_fip" {
  pool = "Ext-Net"
}