terraform {
  backend "swift" {}
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.42.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
    ovh = {
      source = "ovh/ovh"
      version = ">= 0.13.0"
    }
  }
  required_version = ">= 1.0"
}