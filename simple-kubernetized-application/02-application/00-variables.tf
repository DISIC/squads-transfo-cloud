// ----------- GLOBAL -----------
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


// ----- MARIADB DATABASE ----
variable "mariadb_database"{
    type        = string
    default     = "wordpress_db"
    description = ""
}

variable "mariadb_user"{
    type        = string
    default     = "wordpress"
    description = ""
}

// ----------- LOCALS -----------
locals{
    
    mariadb_secrets = ["mariadb-root-password","mariadb-password","mariadb-replication-password"]

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
