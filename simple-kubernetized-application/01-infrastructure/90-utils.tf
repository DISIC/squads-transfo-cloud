# =============================================================================
#       Scaleway - Kubernetes config files
# =============================================================================

resource "local_file" "k8s_kubeconfig" {
  content = scaleway_k8s_cluster.k8s_kapsule_cluster.kubeconfig[0].config_file
  filename = "${path.module}/../02-application/kubeconfig"
}

resource "local_file" "k8s_certificate" {
  content = scaleway_k8s_cluster.k8s_kapsule_cluster.kubeconfig[0].cluster_ca_certificate
  filename = "${path.module}/../02-application/certificate"
}