// --------------------- Providers --------------------

provider "openstack" {
  auth_url = "https://auth.cloud.ovh.net/v3/"
  cloud    = var.environment
  region   = var.region
}

provider "template" {}

provider "ovh" {
  alias              = "ovh"
  endpoint           = "ovh-eu"
  application_key    = ""
  application_secret = ""
  consumer_key       = ""
}
