# =============================================================================
# Helm - Install Gitlab
# =============================================================================

resource "helm_release" "wordpress" {
  name       = "wordpress"
  namespace  = kubernetes_namespace.wordpress_namespace.metadata[0].name
  timeout    = 600

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "wordpress"
  version    = "15.2.5"
  
  values = [for file in data.template_file.helm_values: file.rendered]

  depends_on = [kubernetes_secret.wordpress_password, kubernetes_secret.mariadb_password]
}