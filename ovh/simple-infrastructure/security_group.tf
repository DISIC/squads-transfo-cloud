resource "openstack_networking_secgroup_v2" "front_secgroup" {
  name = "front_secgroup"
  description = "front instance's security group"
}

resource "openstack_networking_secgroup_rule_v2" "front_secgroup_rule_ssh" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = "22"
  port_range_max = "22"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.front_secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "front_secgroup_rule_http" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = "80"
  port_range_max = "80"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.front_secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "front_secgroup_rule_https" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = "443"
  port_range_max = "443"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.front_secgroup.id
}

# data "openstack_networking_secgroup_v2" "default" {
#   name = "default"
# }