output "bastion_fip" {
  description = "FIP de l'Application"
  value       = openstack_networking_floatingip_associate_v2.associate_fixed_appli_floating_ip.floating_ip
}