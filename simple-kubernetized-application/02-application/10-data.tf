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
      wordpress_admin_secret_name = kubernetes_secret.wordpress_password.metadata[0].name
  }
}