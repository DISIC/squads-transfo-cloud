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
  application_key    = "1961f136c5b03711"
  application_secret = "b4417ce43ff41c70c39f51d5edeeb068"
  consumer_key       = "0654bbc1465bee0929f34a5877d9608c"
}