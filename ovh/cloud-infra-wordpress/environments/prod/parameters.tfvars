// -------- Globals ----------
region      = "GRA11"
zone        = "IGN"
environment = "ovh-test"

// -------- Specific ----------

# Réseaux FIP
fip_public_network_name = "Ext-Net"
fip_publication_network_name    = "Ext-Net"

# Networking
pub_subnet_cidr = "10.0.4.0/24"
db_subnet_cidr   = "10.0.5.0/24"
main_gateway_ip  = "10.0.4.254"
pub_gateway_ip    = "10.0.5.254"

admin_static_routes = [
    {
        destination = "0.0.0.0/0"
        nexthop = "{{ int_adm_gw }}"
        description = "Route to internet"
    }
]

# DNS
dns_nameservers = ["8.8.4.4"]

# Bastion
key_pair            = "admin_ssh"
bastion_image_name  = "Ubuntu 20.04"
bastion_flavor_name = "s1-2"
app_image_name      = "Ubuntu 20.04"
app_flavor_name     = "s1-2"
