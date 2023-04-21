# =============================================================================
#     Getting template files HELM values
# =============================================================================

data "template_file" "helm_values" {
  for_each = fileset("${path.module}/files/configs/wordpress/", "*.yml")

  template = file("${path.module}/files/configs/wordpress/${each.key}")

  vars = {
      # MARIADB
      mariadb_database            = var.mariadb_database
      mariadb_user                = var.mariadb_user
      mariadb_secret_name         = kubernetes_secret.mariadb_password.metadata[0].name

      # WORDPRESS
      replica_count               = var.wordpress_replica_count
      wordpress_admin_secret_name = kubernetes_secret.wordpress_password.metadata[0].name
  }
}

data "terraform_remote_state" "remote_state"{
  backend = "s3"

  config = {
    bucket = "formation-terraform-mef-tfstates"
    key    = "tbourgois/module-4/infrastructure/terraform.tfstate"
    region                      = "fr-par"
    endpoint                    = "https://s3.fr-par.scw.cloud"
    skip_credentials_validation = true
    skip_region_validation      = true
  }
}