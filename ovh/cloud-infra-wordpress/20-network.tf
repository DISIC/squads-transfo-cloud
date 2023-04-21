// --------------------- Network --------------------
resource "openstack_networking_network_v2" "main_network" {
  name           = "${local.tags["nubothon:short-name"]}-main-network"
  admin_state_up = true
}

resource "openstack_networking_subnet_v2" "pub_subnet" {
  name            = "${local.tags["nubothon:short-name"]}-pub-subnet"
  network_id      = openstack_networking_network_v2.main_network.id
  cidr            = var.pub_subnet_cidr
  ip_version      = 4
  dns_nameservers = compact(var.dns_nameservers)
  enable_dhcp     = true
  gateway_ip      = var.main_gateway_ip
}

resource "openstack_networking_router_v2" "pub_router" {
  name                = "${local.tags["nubothon:short-name"]}-pub-router"
  external_network_id = data.openstack_networking_network_v2.public_network.id
}

resource "openstack_networking_router_interface_v2" "pub_router_interface" {
  router_id = openstack_networking_router_v2.pub_router.id
  subnet_id = openstack_networking_subnet_v2.pub_subnet.id
}

resource "openstack_networking_subnet_v2" "db_subnet" {
  name        = "${local.tags["nubothon:short-name"]}-db-subnet"
  network_id  = openstack_networking_network_v2.main_network.id
  cidr        = var.db_subnet_cidr
  ip_version  = 4
  dns_nameservers = compact(var.dns_nameservers)
  enable_dhcp = true
  gateway_ip  = var.pub_gateway_ip
}

resource "openstack_networking_router_interface_v2" "db_router_interface" {
  router_id = openstack_networking_router_v2.pub_router.id
  subnet_id = openstack_networking_subnet_v2.db_subnet.id
}


################################
# Création des IPs flottantes
################################
resource "openstack_networking_floatingip_v2" "fip_public" {
  pool  = var.fip_public_network_name
}