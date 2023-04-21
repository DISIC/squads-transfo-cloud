resource "openstack_networking_secgroup_v2" "sg_app" {
  name = "${local.tags["nubothon:short-name"]}-sg-app"
}

resource "openstack_networking_secgroup_rule_v2" "sg_app_rule_ssh" {
  port_range_min    = 22
  port_range_max    = 22
  protocol          = "tcp"
  direction         = "ingress"
  remote_ip_prefix  = "0.0.0.0/0"
  ethertype         = "IPv4"
  security_group_id = openstack_networking_secgroup_v2.sg_app.id
}

resource "openstack_networking_secgroup_rule_v2" "sg_app_rule_http" {
  port_range_min    = 80
  port_range_max    = 80
  protocol          = "tcp"
  direction         = "ingress"
  remote_ip_prefix  = "0.0.0.0/0"
  ethertype         = "IPv4"
  security_group_id = openstack_networking_secgroup_v2.sg_app.id
}

resource "openstack_networking_secgroup_rule_v2" "sg_app_rule_https" {
  port_range_min    = 443
  port_range_max    = 443
  protocol          = "tcp"
  direction         = "ingress"
  remote_ip_prefix  = "0.0.0.0/0"
  ethertype         = "IPv4"
  security_group_id = openstack_networking_secgroup_v2.sg_app.id
}

resource "openstack_networking_secgroup_rule_v2" "sg_app_rule_http_8080" {
  port_range_min    = 8080
  port_range_max    = 8080
  protocol          = "tcp"
  direction         = "ingress"
  remote_ip_prefix  = "0.0.0.0/0"
  ethertype         = "IPv4"
  security_group_id = openstack_networking_secgroup_v2.sg_app.id
}

resource "openstack_networking_secgroup_rule_v2" "sg_app_rule_msql" {
  port_range_min    = 3306
  port_range_max    = 3306
  protocol          = "tcp"
  direction         = "ingress"
  remote_ip_prefix  = "0.0.0.0/0"
  ethertype         = "IPv4"
  security_group_id = openstack_networking_secgroup_v2.sg_app.id
}

resource "openstack_networking_secgroup_rule_v2" "sg_app_rule_icmp" {
  protocol          = "icmp"
  direction         = "ingress"
  remote_ip_prefix  = "0.0.0.0/0"
  ethertype         = "IPv4"
  security_group_id = openstack_networking_secgroup_v2.sg_app.id
}
