// ----------- GLOBAL -----------
variable "region" {
  type        = string
  description = "Nom de la région de déploiement"
  default     = "NUBP11"
}

variable "zone" {
  type        = string
  description = "Nom de la zone de déploiement"
  default     = "CISIRH"
}

variable "environment" {
  type        = string
  description = "Environnement de déploiement du projet"
  default     = "dev"
}

# Réseaux FIP
variable "fip_public_network_name" {
  type        = string
  description = "Nom de la FIP du réseau d'public"
}

variable "fip_publication_network_name" {
  type        = string
  description = "Nom de la FIP du réseau de publication"
}

# DNS
variable "dns_nameservers" {
  type        = list(string)
  description = "Liste des adresses IP des serveurs DNS"
}


# Réseaux
variable "pub_subnet_cidr" {
  type        = string
  description = "Admin subnet CIDR"
  default     = "172.18.0.0/24"
}

variable "db_subnet_cidr" {
  type        = string
  description = "Internal subnet CIDR"
  default     = "172.16.0.0/24"
}

variable "main_gateway_ip" {
  type        = string
  description = "IP de la passerelle du réseau d'public"
  default     = "172.18.0.254"
}

variable "pub_gateway_ip" {
  type        = string
  description = "IP de la passerelle du réseau de publication"
  default     = "172.16.0.254"
}

variable "admin_static_routes" {
  type        = list(any)
  description = "Liste des routes statiques"
}

variable "extra_admin_static_route" {
  type        = list(any)
  description = "Liste des routes statiques supplémentaires"
  default     = []
}


# Bastion
variable "key_pair" {
  type        = string
  description = "Nom de la clé SSH"
}

variable "bastion_image_name" {
  type        = string
  description = "Nom de l'image Linux de la VM bastion"
  default     = "rocky8"
}

variable "bastion_flavor_name" {
  type        = string
  description = "Bastion flavor"
  default     = "CO1.1"
}

# App
variable "app_image_name" {
  type        = string
  description = "Nom de l'image Linux de la VM App"
  default     = "rocky8"
}

variable "app_flavor_name" {
  type        = string
  description = "App flavor"
  default     = "CO1.4"
}

variable "fixed_bastion_fip" {
  type        = string
  description = "FIP fixe pour le bastion"
  default     = ""
}

variable "fixed_application_fip" {
  type        = string
  description = "FIP fixe pour l'application"
  default     = ""
}

// ----------- LOCALS -----------
locals {
  admin_static_routes = concat(var.admin_static_routes, var.extra_admin_static_route)

  tag_list = [for key, value in local.tags : "${key}=${value}"]

  tags = {
    "nubothon:deployment" = "terraform",
    "nubothon:region"     = var.region,
    "nubothon:zone"       = var.zone,
    "nubothon:env"        = var.environment,
    "nubothon:project"    = "cloud-infra-application",
    "nubothon:short-name" = "virtual-application"
  }

}