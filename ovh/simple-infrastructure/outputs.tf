output "public_ip" {
  value = openstack_networking_floatingip_associate_v2.associate_fixed_appli_floating_ip.floating_ip
}

output "private_ip" {
  value = openstack_compute_instance_v2.instance.network.0.fixed_ip_v4
}