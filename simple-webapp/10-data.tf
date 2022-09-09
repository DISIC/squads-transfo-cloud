// ----------- INSTANCE AMI -----------
data "scaleway_instance_image" "ubuntu" {
    name   = var.server_image
    latest = true
}

//--------- INSTANCE CLOUD-INIT -------
data "template_file" "userdata" {
  template = file("./scripts/cloud-init-user-data")

  vars = {
      db_username   = scaleway_rdb_user.db_admin.name,
      db_password   = scaleway_rdb_user.db_admin.password,
      db_ip_address = scaleway_rdb_instance.main_db_instance.load_balancer.0.ip,
      db_port       = scaleway_rdb_instance.main_db_instance.load_balancer.0.port,
      db_name       = scaleway_rdb_database.main.name
  }
}
