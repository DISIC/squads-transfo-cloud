// ----------- INSTANCE AMI -----------
data "scaleway_instance_image" "ubuntu" {
    name   = var.server_image
    latest = true
}

//--------- INSTANCE CLOUD-INIT -------
data "template_file" "userdata" {
  template = file("./scripts/cloud-init-user-data")

  vars = {
    user           = var.username
  }
}
