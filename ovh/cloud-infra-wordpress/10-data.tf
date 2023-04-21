// --------------------- DATA --------------------

###########################
# DNS
###########################
/*
data "openstack_dns_zone_v2" "zone_dns" {}
*/

###########################
# NETWORKING
###########################
data "openstack_networking_network_v2" "public_network" {
  name = var.fip_public_network_name
}

data "openstack_networking_network_v2" "pub_network" {
  name = var.fip_publication_network_name
}


###########################
# IMAGES
###########################

data "openstack_images_image_v2" "bastion_image" {
  name        = var.bastion_image_name
  most_recent = true
}

data "openstack_images_image_v2" "app_image" {
  name        = var.app_image_name
  most_recent = true
}

/*
data "openstack_images_image_v2" "golden_image_app" {
  name        = "cloud-infra-application-v2.2"
  most_recent = true
}
*/
###########################
# USERDATA
###########################

/*
data "template_file" "userdata_admin" {
  template = file("./scripts/cloud-init-user-data-admin.tpl")

  vars = {
    DNSResolution = local.dns_rules
  }
}

data "template_file" "userdata" {
  template = file("./scripts/cloud-init-user-data.tpl")

  vars = {
    DNSResolution = local.dns_rules
  }
}
*/