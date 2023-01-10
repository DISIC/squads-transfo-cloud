# Formation Terraform - Module 2 - Déployer une infrastructure simple

Déploiement d’une infrastructure simple (VM, Réseau, IAM) avec Terraform sur Scaleway

## Versions

Use Terraform `0.14+` and Terraform Provider Scaleway `2.0+`.


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
| <a name="provider_scaleway"></a> [scaleway](#provider\_scaleway) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [scaleway_account_ssh_key.main_ssh_key](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/account_ssh_key) | resource |
| [scaleway_instance_security_group.scaleway_instance_sg](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_security_group) | resource |
| [scaleway_instance_server.scaleway_instance](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_server) | resource |
| [scaleway_instance_volume.additional_volume](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_volume) | resource |
| [scaleway_instance_image.ubuntu](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/instance_image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `"dev"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | ----------- GLOBAL ----------- | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"fr-par"` | no |
| <a name="input_server_image"></a> [server\_image](#input\_server\_image) | ---------- SERVER --------- | `string` | `"Ubuntu 20.04 Focal Fossa"` | no |
| <a name="input_server_type"></a> [server\_type](#input\_server\_type) | Type and size of the Server | `string` | `"DEV1-M"` | no |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | ----------- IAM ----------- | `string` | `"admin_ssh"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | n/a | `string` | `"fr-par-1"` | no |

## Outputs

No outputs.