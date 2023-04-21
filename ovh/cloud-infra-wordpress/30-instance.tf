## Admin
resource "openstack_compute_instance_v2" "app_instance" {
  name        = "${local.tags["nubothon:short-name"]}-app-instance"
  flavor_name = var.app_flavor_name
  key_pair    = var.key_pair
  user_data   = templatefile("./scripts/cloud-init-user-data-app.tpl", {})

  block_device {
    uuid                  = data.openstack_images_image_v2.app_image.id
    source_type           = "image"
    volume_size           = 30
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }

  network {
    port = openstack_networking_port_v2.port_app.id
  }

  metadata = merge(local.tags, { "dinum:name" = "${local.tags["nubothon:short-name"]}-haproxy-instance" })

  lifecycle {
    ignore_changes        = [key_pair, block_device]
    create_before_destroy = false
  }
}

resource "openstack_networking_port_v2" "port_app" {
  name       = "${local.tags["nubothon:short-name"]}-app-instance-port"
  network_id = openstack_networking_network_v2.main_network.id

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.pub_subnet.id
  }

  admin_state_up     = "true"
  security_group_ids = [openstack_networking_secgroup_v2.sg_app.id]
}

# Associate APP floating IPs (if fixed FIP)
resource "openstack_networking_floatingip_associate_v2" "associate_fixed_appli_floating_ip" {
  floating_ip = openstack_networking_floatingip_v2.fip_public.address
  port_id     = openstack_networking_port_v2.port_app.id

  depends_on = [
    openstack_networking_router_interface_v2.pub_router_interface
  ]
}



## Application 
resource "openstack_compute_instance_v2" "db_instance" {
  name        = "${local.tags["nubothon:short-name"]}-db-instance"
  flavor_name = var.app_flavor_name
  key_pair    = var.key_pair
  user_data   = templatefile("./scripts/cloud-init-user-data-db.tpl", {})
  block_device {
    #uuid                  = data.openstack_images_image_v2.golden_image_app.id
    uuid                  = data.openstack_images_image_v2.app_image.id
    source_type           = "image"
    volume_size           = 30
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }

  network {
    port = openstack_networking_port_v2.port_db.id
  }

  metadata = merge(local.tags, { "dinum:name" = "${local.tags["nubothon:short-name"]}-db-instance" })

  lifecycle {
    ignore_changes        = [key_pair, block_device]
    create_before_destroy = false
  }
}

resource "openstack_networking_port_v2" "port_db" {
  name       = "${local.tags["nubothon:short-name"]}-db-instance-port"
  network_id = openstack_networking_network_v2.main_network.id

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.db_subnet.id
  }

  admin_state_up     = "true"
  security_group_ids = [openstack_networking_secgroup_v2.sg_app.id]
}