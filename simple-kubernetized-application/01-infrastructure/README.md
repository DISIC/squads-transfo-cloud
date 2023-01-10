<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_scaleway"></a> [scaleway](#provider\_scaleway) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.k8s_certificate](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.k8s_kubeconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [scaleway_account_ssh_key.main_ssh_key](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/account_ssh_key) | resource |
| [scaleway_k8s_cluster.k8s_kapsule_cluster](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/k8s_cluster) | resource |
| [scaleway_k8s_pool.k8s_kapsule_pool](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/k8s_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `"dev"` | no |
| <a name="input_k8s_cluster_node_type"></a> [k8s\_cluster\_node\_type](#input\_k8s\_cluster\_node\_type) | The commercial type of the pool instances. Instances with insufficient memory are not eligible (DEV1-S, PLAY2-PICO, STARDUST). | `string` | `"DEV1-M"` | no |
| <a name="input_k8s_cluster_type"></a> [k8s\_cluster\_type](#input\_k8s\_cluster\_type) | The type of Kubernetes cluster to deploy | `string` | `"kapsule"` | no |
| <a name="input_k8s_cluster_version"></a> [k8s\_cluster\_version](#input\_k8s\_cluster\_version) | The version of the Kubernetes cluster | `string` | `"1.24.5"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | ----------- GLOBAL ----------- | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"fr-par"` | no |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | ----------- IAM ----------- | `string` | `"admin_ssh"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | n/a | `string` | `"fr-par-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_k8s_pool_name"></a> [k8s\_pool\_name](#output\_k8s\_pool\_name) | Name of the kubernetes pool name |
<!-- END_TF_DOCS -->