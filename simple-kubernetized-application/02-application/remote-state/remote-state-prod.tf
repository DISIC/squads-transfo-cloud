bucket                      = "formation-terraform-ministere-justice-tfstates"  // change with your bucket name
key                         = "module-4/application/prod/terraform.tfstate"
region                      = "fr-par"
endpoint                    = "https://s3.fr-par.scw.cloud"
skip_credentials_validation = true
skip_region_validation      = true