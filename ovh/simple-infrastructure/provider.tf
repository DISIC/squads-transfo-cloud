# Configure le fournisseur OpenStack hébergé par OVHcloud
provider "openstack" {
  auth_url    = "https://auth.cloud.ovh.net/v3/" # URL d'authentification
  domain_name = "default"                        # Nom de domaine - Toujours à "default" pour OVHcloud
}

provider "ovh" {
  endpoint = "ovh-eu"
  # application_key    = "<votre_access_key>"
  # application_secret = "<votre_application_secret>"
  # consumer_key       = "<votre_consumer_key>"
}