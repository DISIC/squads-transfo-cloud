# =============================================================================
#       Terraform - Variables
# =============================================================================

// ----------- GLOBAL -----------
variable "project_id"{
    type        = string
    description = ""
}

variable "region"{
    type        = string
    default     = "fr-par"
    description = ""
}

variable "zone"{
    type        = string
    default     = "fr-par-1"
    description = ""
}

variable "environment"{
    type        = string
    default     = "dev"
    description = ""
}

// ----------- IAM -----------
variable "ssh_key_name" {
    type        = string
    default     = "admin_ssh"
    description = ""
}

// ---------- CLUSTER ---------
variable "k8s_cluster_type" {
    type        = string
    default     = "kapsule"
    description = "The type of Kubernetes cluster to deploy"
    validation {
        condition     = anytrue([var.k8s_cluster_type == "kapsule", var.k8s_cluster_type == "multicloud"])
        error_message = "The k8s_cluster_type value must be a valid Scaleway K8S cluster type (kapsule or multicloud)."
    }
}

variable "k8s_cluster_version" {
    type        = string
    default     = "1.24.5"
    description = "The version of the Kubernetes cluster"
}

variable "k8s_cluster_node_type" {
    type        = string
    default     = "DEV1-M"
    description = "The commercial type of the pool instances. Instances with insufficient memory are not eligible (DEV1-S, PLAY2-PICO, STARDUST)."
    validation {
        condition     = can(regex("^(DEV1-(M|L|XL))|(GP1-(XS|S|M|L|XL))$", var.k8s_cluster_node_type))
        error_message = "The node_type value must be a valid Scaleway instance type (DEV1-M, DEV1-L, DEV1-XL, GP1-XS, GP1-S, GP1-M, GP1-L, GP1-XL)."
    }
}

// ----------- LOCALS -----------
locals{
    tag_list = [
        "dinum:deployment=terraform",
        "dinum:region=${var.region}",
        "dinum:zone=${var.zone}",
        "dinum:env=${var.environment}",
        "dinum:project=cloud-wordpress-infra"
    ]

    tags = {
        "dinum:deployment" = "terraform"
        "dinum:region"     = var.region
        "dinum:zone"       = var.zone
        "dinum:env"        = var.environment
        "dinum:project"    = "cloud-wordpress-infra"
    }

}
