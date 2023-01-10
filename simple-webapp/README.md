# Formation Terraform - Module 3 - Déployer une infrastructure applicative simple

Déploiement d’une infrastructure simple (VM, Réseau, IAM, DB) avec une application conteneurisée à l'aide de Terraform sur Scaleway

## Versions

Use Terraform `0.14+` and Terraform Provider Scaleway `2.0+`.

These types of resources are supported:

## Usage

```hcl

terraform init
terraform apply

```

With variables :

```hcl

terraform init --backend-config ./remote-state/remote-state.tf
terraform apply --var-file ./parameters/parameters.tfvars

```


## Documentation

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_scaleway"></a> [scaleway](#provider\_scaleway) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_password.db_master_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.db_user_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [scaleway_account_ssh_key.main_ssh_key](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/account_ssh_key) | resource |
| [scaleway_instance_security_group.scaleway_instance_sg](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_security_group) | resource |
| [scaleway_instance_server.scaleway_instance](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_server) | resource |
| [scaleway_instance_volume.additional_volume](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_volume) | resource |
| [scaleway_rdb_acl.main_db_instance](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/rdb_acl) | resource |
| [scaleway_rdb_database.main](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/rdb_database) | resource |
| [scaleway_rdb_instance.main_db_instance](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/rdb_instance) | resource |
| [scaleway_rdb_privilege.admin_privilege](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/rdb_privilege) | resource |
| [scaleway_rdb_privilege.master_privilege](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/rdb_privilege) | resource |
| [scaleway_rdb_user.db_admin](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/rdb_user) | resource |
| [scaleway_vpc_gateway_network.main](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_gateway_network) | resource |
| [scaleway_vpc_private_network.main_vpc_pn](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_private_network) | resource |
| [scaleway_vpc_public_gateway.main_public_gateway](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_public_gateway) | resource |
| [scaleway_vpc_public_gateway_dhcp.main](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_public_gateway_dhcp) | resource |
| [scaleway_vpc_public_gateway_ip.main](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_public_gateway_ip) | resource |
| [scaleway_vpc_public_gateway_pat_rule.main](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_public_gateway_pat_rule) | resource |
| [scaleway_instance_image.ubuntu](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/instance_image) | data source |
| [template_file.userdata](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_engine"></a> [database\_engine](#input\_database\_engine) | n/a | `string` | `"PostgreSQL-11"` | no |
| <a name="input_database_type"></a> [database\_type](#input\_database\_type) | ---------- DATABASE --------- | `string` | `"db-dev-s"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `"dev"` | no |
| <a name="input_private_subnet_cidr_block"></a> [private\_subnet\_cidr\_block](#input\_private\_subnet\_cidr\_block) | ---------- VPC PN --------- | `string` | `"192.168.1.0/24"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | ----------- GLOBAL ----------- | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"fr-par"` | no |
| <a name="input_server_image"></a> [server\_image](#input\_server\_image) | ---------- SERVER --------- | `string` | `"Ubuntu 20.04 Focal Fossa"` | no |
| <a name="input_server_type"></a> [server\_type](#input\_server\_type) | n/a | `string` | `"DEV1-M"` | no |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | ----------- IAM ----------- | `string` | `"admin_ssh"` | no |
| <a name="input_username"></a> [username](#input\_username) | n/a | `string` | `"user"` | no |
| <a name="input_vpc_public_gateway_type"></a> [vpc\_public\_gateway\_type](#input\_vpc\_public\_gateway\_type) | n/a | `string` | `"VPC-GW-S"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | n/a | `string` | `"fr-par-1"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->