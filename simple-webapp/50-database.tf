// ----------- Database -----------
resource "scaleway_rdb_instance" "main_db_instance" {
    name      = "fr-rdb-${local.tags["dinum:project"]}-${var.environment}"
    
    node_type = var.database_type
    engine    = var.database_engine
    
    is_ha_cluster  = false
    disable_backup = true
    
    user_name = "root"
    password  = random_password.db_master_password.result
    
    private_network {
        ip_net = "192.168.1.254/24"
        pn_id  = scaleway_vpc_private_network.main_vpc_pn.id
    }

    tags = concat(local.tag_list,["dinum:name=fr-rdb-${local.tags["dinum:project"]}-${var.environment}"])
}

resource "scaleway_rdb_database" "main" {
    instance_id    = scaleway_rdb_instance.main_db_instance.id
    name           = "mattermost_db"
}

resource "scaleway_rdb_privilege" "master_privilege" {
    instance_id   = scaleway_rdb_instance.main_db_instance.id
    user_name     = scaleway_rdb_instance.main_db_instance.user_name
    database_name = scaleway_rdb_database.main.name
    permission    = "all"
}

resource "scaleway_rdb_user" "db_admin" {
    instance_id = scaleway_rdb_instance.main_db_instance.id
    name        = "mattermost"
    password    = random_password.db_user_password.result
    is_admin    = true
}

resource "scaleway_rdb_privilege" "admin_privilege" {
    instance_id   = scaleway_rdb_instance.main_db_instance.id
    user_name     = scaleway_rdb_user.db_admin.name
    database_name = scaleway_rdb_database.main.name
    permission    = "all"
}

resource "scaleway_rdb_acl" "main_db_instance" {
    instance_id = scaleway_rdb_instance.main_db_instance.id

    acl_rules {
        ip          = "${scaleway_instance_server.scaleway_instance.private_ip}/32"
        description = "Accept traffic from Application Instance"
    }

    acl_rules {
        ip          = "${scaleway_instance_server.scaleway_instance.public_ip}/32"
        description = "Accept traffic from Application Instance"
    }

}

// ----------- Networking -----------
resource "scaleway_vpc_public_gateway_pat_rule" "main" {
    gateway_id   = scaleway_vpc_public_gateway.main_public_gateway.id
    private_ip   = scaleway_vpc_public_gateway_dhcp.main.address
    private_port = scaleway_rdb_instance.main_db_instance.private_network.0.port
    public_port  = 42
    protocol     = "both"
}

//  ------ Random Generator ---------
resource "random_password" "db_master_password" {
    length  = 10

    lower   = true
    upper   = true
    numeric = true
    special = true

    min_lower   = 1
    min_upper   = 1
    min_numeric = 1
    min_special = 1

    override_special = "!#$%&+-"
}

resource "random_password" "db_user_password" {
    length  = 10

    lower   = true
    upper   = true
    numeric = true
    special = true

    min_lower   = 1
    min_upper   = 1
    min_numeric = 1
    min_special = 1

    override_special = "!#$%&+-"
}