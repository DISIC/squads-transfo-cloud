// --------------------- State --------------------

terraform {
  backend "s3" {}
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
    }
  }
  required_version = ">= 1.0"
}

