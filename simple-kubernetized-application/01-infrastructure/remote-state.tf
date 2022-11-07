# =============================================================================
#       Terraform - Remote Backend
# =============================================================================

terraform {
  backend "s3" {}
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
    }
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
  }
  required_version = ">= 1.0"
}