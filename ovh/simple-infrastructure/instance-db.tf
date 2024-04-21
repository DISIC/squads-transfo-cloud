resource "openstack_networking_secgroup_v2" "db_secgroup" {
  name = "db_secgroup"
  description = "db instance's security group"
}

resource "openstack_networking_secgroup_rule_v2" "db_secgroup_rule_ssh" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min ="22"
  port_range_max = "22"
  remote_ip_prefix = var.public_subnet_cidr
  security_group_id = openstack_networking_secgroup_v2.db_secgroup.id
}

resource "openstack_networking_port_v2" "db_port" {
  name = "db_port"
  network_id = openstack_networking_network_v2.private_network.id

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.private_subnet.id
  }

  admin_state_up = "true"
  security_group_ids = [openstack_networking_secgroup_v2.db_secgroup.id]
}

resource "openstack_compute_instance_v2" "instance_db" {
  name = "db_instance"
  image_id = data.openstack_images_image_v2.ubuntu.id
  flavor_name = var.flavor_name
  key_pair = openstack_compute_keypair_v2.main_ssh_key.id

  network {
    port = openstack_networking_port_v2.db_port.id
  }
}

resource "openstack_blockstorage_volume_v2" "additional_volume" {
  name = "simple_volume"
  size = 10
}

resource "openstack_compute_volume_attach_v2" "volume" {
  instance_id = openstack_compute_instance_v2.instance_db.id
  volume_id = openstack_blockstorage_volume_v2.additional_volume.id
}