terraform {
required_version    = ">= 0.14.0"                    
  required_providers {
    ovh = {
      source  = "ovh/ovh"
    }
  }
}

provider "ovh" {
  endpoint           = "ovh-eu"
  application_key    = ""
  application_secret = ""
  consumer_key       = ""
}
