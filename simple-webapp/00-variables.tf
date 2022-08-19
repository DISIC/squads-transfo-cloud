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
// ---------- VPC PN ---------
variable "private_subnet_cidr_block" {
    type        = string
    default     = "192.168.1.0/24"
    description = ""
}

variable "vpc_public_gateway_type" {
    type        = string
    default     = "VPC-GW-S"
    description = ""
}

// ----------- IAM -----------
variable "ssh_key_name" {
    type        = string
    default     = "admin_ssh"
    description = ""
}

// ---------- SERVER ---------
variable "server_image" {
    type        = string
    default     = "Ubuntu 20.04 Focal Fossa"
    description = ""
}

variable "server_type" {
    type        = string
    default     = "DEV1-M"
    description = ""
    validation {
        condition     = can(regex("^(DEV1-(S|M|L|XL))|(GP1-(XS|S|M|L|XL))$", var.server_type))
        error_message = "The server_type value must be a valid Scaleway instance type (DEV1-S, DEV1-M, DEV1-L, DEV1-XL, GP1-XS, GP1-S, GP1-M, GP1-L, GP1-XL)."
    }
}

variable "username" {
    type        = string
    default     = "user"
    description = ""
}

// ---------- DATABASE ---------
variable "database_type" {
    type        = string
    default     = "db-dev-s"
    description = ""
}

variable "database_engine" {
    type        = string
    default     = "PostgreSQL-11"
    description = ""
}

// ----------- LOCALS -----------
locals{
    tag_list = [
        "dinum:deployment=terraform",
        "dinum:region=${var.region}",
        "dinum:zone=${var.zone}",
        "dinum:env=${var.environment}",
        "dinum:project=cloud-simple-infra"
    ]

    tags = {
        "dinum:deployment" = "terraform"
        "dinum:region"     = var.region
        "dinum:zone"       = var.zone
        "dinum:env"        = var.environment
        "dinum:project"    = "cloud-simple-infra"
    }

}
