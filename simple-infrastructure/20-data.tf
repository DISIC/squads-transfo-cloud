// ----------- INSTANCE AMI -----------
data "scaleway_instance_image" "ubuntu" {
    name   = var.server_image
    latest = true
}