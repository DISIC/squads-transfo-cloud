resource "openstack_compute_keypair_v2" "main_ssh_key" {
  name       = "main_ssh_key"
  public_key = file("./main_ssh_key.pub")
}

resource "openstack_networking_port_v2" "port" {
  name       = "front port"
  network_id = openstack_networking_network_v2.private_network.id

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.public_subnet.id
  }

  admin_state_up     = "true"
  security_group_ids = [openstack_networking_secgroup_v2.front_secgroup.id]
}

resource "openstack_networking_floatingip_associate_v2" "associate_fixed_appli_floating_ip" {
  floating_ip = openstack_networking_floatingip_v2.front_fip.address
  port_id     = openstack_networking_port_v2.port.id

  depends_on = [ openstack_networking_router_interface_v2.router_interface_public ]
}

resource "openstack_compute_instance_v2" "instance" {
  name        = "instance"
  image_id    = data.openstack_images_image_v2.ubuntu.id
  flavor_name = var.flavor_name
  key_pair    = openstack_compute_keypair_v2.main_ssh_key.name

  block_device {
    uuid                  = data.openstack_images_image_v2.ubuntu.id
    source_type           = "image"
    volume_size           = 30
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }

  network {
    port = openstack_networking_port_v2.port.id
  }
}