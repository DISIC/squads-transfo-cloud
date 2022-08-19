// ----------- IAM -----------
resource "scaleway_account_ssh_key" "main_ssh_key" {
    name       = "fr-ssh-key-${local.tags["dinum:project"]}-main"
    public_key = file("./files/${var.ssh_key_name}.pub")

    lifecycle {
        ignore_changes = [public_key]
    }
}