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
  application_key    = "bf8810c41fb0bf31"
  application_secret = "b5e665ab3777c4259476f871ba321dbf"
  consumer_key       = "c5ec8fecb17aa358e1486ab3a3d6a587"
}