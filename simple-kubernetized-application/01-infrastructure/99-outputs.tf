# =============================================================================
#       Scaleway - Outputs
# =============================================================================

output "k8s_pool_name" {
  value       = scaleway_k8s_pool.k8s_kapsule_pool.name
  description = "Name of the kubernetes pool name"
}