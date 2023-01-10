<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.0.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.13.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.0.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.13.1 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.wordpress](https://registry.terraform.io/providers/hashicorp/helm/2.0.1/docs/resources/release) | resource |
| [kubernetes_namespace.wordpress_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/2.13.1/docs/resources/namespace) | resource |
| [kubernetes_secret.mariadb_password](https://registry.terraform.io/providers/hashicorp/kubernetes/2.13.1/docs/resources/secret) | resource |
| [kubernetes_secret.wordpress_password](https://registry.terraform.io/providers/hashicorp/kubernetes/2.13.1/docs/resources/secret) | resource |
| [random_password.mariadb_master_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.mariadb_replicator_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.mariadb_user_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.wordpress_admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [template_file.helm_values](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `"dev"` | no |
| <a name="input_mariadb_database"></a> [mariadb\_database](#input\_mariadb\_database) | ----- MARIADB DATABASE ---- | `string` | `"wordpress_db"` | no |
| <a name="input_mariadb_user"></a> [mariadb\_user](#input\_mariadb\_user) | n/a | `string` | `"wordpress"` | no |
| <a name="input_region"></a> [region](#input\_region) | ----------- GLOBAL ----------- | `string` | `"fr-par"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | n/a | `string` | `"fr-par-1"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->