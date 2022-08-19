// ----------- VPC Private Network -----------
resource "scaleway_vpc_private_network" "main_vpc_pn" {
    name = "fr-vpc-pn-${local.tags["dinum:project"]}-${var.environment}"

    tags = concat(local.tag_list,["dinum:name=fr-vpc-pn-${local.tags["dinum:project"]}-${var.environment}"])
}

// ----------- VPC Public Gateway -----------
resource "scaleway_vpc_public_gateway_dhcp" "main" {
    subnet = var.private_subnet_cidr_block
}

resource "scaleway_vpc_public_gateway_ip" "main" {
    tags = local.tag_list
}

resource "scaleway_vpc_public_gateway" "main_public_gateway" {
    name  = "fr-vpc-pg-${local.tags["dinum:project"]}-${var.environment}"
    type  = var.vpc_public_gateway_type
    ip_id = scaleway_vpc_public_gateway_ip.main.id

    tags = concat(local.tag_list,["dinum:name=fr-vpc-pg-${local.tags["dinum:project"]}-${var.environment}"])
}

resource "scaleway_vpc_gateway_network" "main" {
    gateway_id         = scaleway_vpc_public_gateway.main_public_gateway.id
    private_network_id = scaleway_vpc_private_network.main_vpc_pn.id
    dhcp_id            = scaleway_vpc_public_gateway_dhcp.main.id

    cleanup_dhcp      = true
    enable_masquerade = true
}