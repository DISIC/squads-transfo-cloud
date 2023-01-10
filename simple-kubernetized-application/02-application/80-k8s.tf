# =============================================================================
#     Kubernetes - Namespaces
# =============================================================================
resource "kubernetes_namespace" "wordpress_namespace" {
  metadata { 
    name = "wordpress-${var.environment}" 
  }
}

# =============================================================================
#     Kubernetes - Create Secrets
# =============================================================================

# Database MariaDB Password
resource "kubernetes_secret" "mariadb_password" {
  
  metadata {
    name      = "mariadb-passwords"
    namespace = kubernetes_namespace.wordpress_namespace.metadata[0].name
  }

  data = { 
    mariadb-root-password = random_password.mariadb_master_password.result
    mariadb-password = random_password.mariadb_user_password.result
    mariadb-replication-password = random_password.mariadb_replicator_password.result
  }
  type = "opaque"
}

# Wordpress Password
resource "kubernetes_secret" "wordpress_password" {
  metadata {
    name      = "wordpress-password"
    namespace = kubernetes_namespace.wordpress_namespace.metadata[0].name
  }
  data = { wordpress-password = random_password.wordpress_admin_password.result }
  type = "opaque"
}