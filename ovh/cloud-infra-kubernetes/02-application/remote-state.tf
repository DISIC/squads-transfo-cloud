// --------------------- State --------------------

terraform {
  backend "s3" {}
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.13.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.0.1"
    }
  }
  required_version = ">= 1.0"
}

