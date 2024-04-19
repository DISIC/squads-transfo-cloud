terraform {
  backend "s3" {
    bucket = ""
    key    = ""
    region = "gra"
    endpoints = {
      s3 = "https://s3.gra.io.cloud.ovh.net/"
    }
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.42.0"
    }
    ovh = {
      source  = "ovh/ovh"
      version = ">= 0.13.0"
    }
  }
  required_version = ">= 1.0"
}