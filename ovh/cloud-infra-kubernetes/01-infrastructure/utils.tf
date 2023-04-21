resource "local_file" "kubeconfig" {
  content = ovh_cloud_project_kube.my_kube_cluster.kubeconfig
  filename = "./kubeconfig"
}