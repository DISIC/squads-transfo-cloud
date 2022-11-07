# =============================================================================
#       Scaleway - K8S Cluster & Nodes
# =============================================================================

resource "scaleway_k8s_cluster" "k8s_kapsule_cluster" {
  name        = "fr-k8s-cluster-${local.tags["dinum:project"]}-${var.environment}"
  description = "K8s Kapsule Cluster for ${local.tags["dinum:project"]} on ${var.environment} environment"
  
  type    = var.k8s_cluster_type
  version = var.k8s_cluster_version
  cni     = "weave"

  autoscaler_config {
    disable_scale_down              = false
    scale_down_delay_after_add      = "5m"
    estimator                       = "binpacking"
    expander                        = "random"
    ignore_daemonsets_utilization   = true
    balance_similar_node_groups     = true
    expendable_pods_priority_cutoff = -5
  }

  tags = concat(local.tag_list,["dinum:name=fr-k8s-cluster-${local.tags["dinum:project"]}-${var.environment}"])
}

resource "scaleway_k8s_pool" "k8s_kapsule_pool" {
  cluster_id = scaleway_k8s_cluster.k8s_kapsule_cluster.id
  name       = "fr-k8s-pool-${local.tags["dinum:project"]}-${var.environment}"
  node_type  = var.k8s_cluster_node_type
  
  size         = 2
  min_size     = 2
  max_size     = 3 

  autoscaling        = true
  autohealing        = true

  container_runtime  = "containerd"

  tags = concat(local.tag_list,["dinum:name=fr-k8s-pool-${local.tags["dinum:project"]}-${var.environment}"])
}