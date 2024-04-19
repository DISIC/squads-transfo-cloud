data "openstack_images_image_v2" "ubuntu" {
  name        = "Ubuntu 22.04"
  most_recent = true
}

data "openstack_networking_network_v2" "ext-net" {
  name = "Ext-Net"
}