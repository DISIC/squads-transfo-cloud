// ----------- Security Group -----------
resource "scaleway_instance_security_group" "scaleway_instance_sg" {
  name                    = "fr-sg-${local.tags["dinum:project"]}-${var.environment}"
  description             = "Allow TLS inbound traffic"
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action = "accept"
    port   = "22"
  }

  inbound_rule {
    action = "accept"
    port   = "80"
  }

  inbound_rule {
    action = "accept"
    port   = "8080"
  }

  inbound_rule {
    action = "accept"
    port   = "443"
  }
}

resource "scaleway_instance_volume" "additional_volume" {
  name       = "fr-volume-${local.tags["dinum:project"]}-${var.environment}"
  
  type       = "l_ssd"
  size_in_gb = 20

  tags = concat(local.tag_list,["dinum:name=fr-volume-${local.tags["dinum:project"]}-${var.environment}"])
}

resource "scaleway_instance_server" "scaleway_instance" {
  name  = "fr-vm-${local.tags["dinum:project"]}-${var.environment}"
  type  = var.server_type

  image     = data.scaleway_instance_image.ubuntu.id
  boot_type = "local"
  
  enable_dynamic_ip = true
  security_group_id = scaleway_instance_security_group.scaleway_instance_sg.id
  
  additional_volume_ids = [ scaleway_instance_volume.additional_volume.id ]

  cloud_init = data.template_file.userdata.rendered

  root_volume {
    size_in_gb = 20
  }

  tags = concat(local.tag_list,["dinum:name=fr-${local.tags["dinum:project"]}-vm-${var.environment}"])
}