# Déploiement par terraform d'un serveur applicatif

## Sommaire

- [Déploiement par terraform d'un serveur applicatif Petclinic](#déploiement-par-terraform-dun-serveur-applicatif)
  - [Sommaire](#sommaire)
  - [Description](#description)
  - [Arborescence du projet](#arborescence-du-projet)
  - [Guide d'utilisation du projet](#guide-dutilisation-du-projet)
    - [Pré-requis](#pré-requis)
    - [Configuration du projet (exemple de l'environnement de prod)](#configuration-du-projet-exemple-de-lenvironnement-de-prod)
    - [Création de l'infrastructure](#création-de-linfrastructure)
  - [Divers](#divers)
    - [Cas particulier des IP flottantes admin et publication](#cas-particulier-des-ip-flottantes-admin-et-publication)
    - [Cas particulier des groupes de sécurité](#cas-particulier-des-groupes-de-sécurité)

## Description

Ce module Terraform permet la création d'un serveur applicatif embarquant une application Pet Clinic

- Double réseau dont réseau d'public dédié
- Raccordement aux réseaux externes
- Ajout des routes statiques indispensables
- Création d'un serveur web
- Ajout d'un groupe de sécurité pour le serveur web

Terraform ne s'occupant quand de l'infrastructure, il est ensuite possible d'enchainer avec une partie Ansible pour la configuration/personnalisation système (par ex le [skeleton_web](https://forge.dgfip.finances.rie.gouv.fr/dgfip/odin/squelettes/skeleton_web)).

## Arborescence du projet

Dans le répertoire racine du projet : 
- Dossier `environments` contenant les configurations des environnements :
  - Un répertoire par type d'environnement (prod) contenant chacun :
    - `remote-state.tf` : permet de renseigner les modalités de stockage du tfstate
    - `parameters.tfvars` : fichier spécifique pour chaque bénéficiaire et environnement, permettant d'affecter des valeurs aux variables
- Dossier `scripts` contenant les scripts de configuration au démarrage des instances (cloud-init)
- `00-variables.tf` : contient la liste des variables utilisées avec leur valeur par défaut
- `10-data.tf` : contient l'ensemble des blocs data pour récupérer des informations depuis NUBO
- `20-network.tf` : contient le code de déploiement des réseaux
- `30-instance.tf`: contient le code de déploiement des instances
- `40-security.tf` : contient le code de déploiement des groupes de sécurités
- `50-dns.tf` : contient le code de déploiement des records DNS éventuels à utiliser
- `90-output.tf` : contient les variables à afficher en fin de déploiement
- `provider.tf` : contient la liste des providers à utiliser
- `remote-state.tf` : contient la configuration par défaut pour stocker le tfstate
- `.gitignore` : contient la liste des fichiers à ignorer
- `README.md` : documentation

## Guide d'utilisation du projet

### Pré-requis

Version de [Terraform](https://www.terraform.io/downloads) > 0,13

###  Configuration du projet (exemple de l'environnement de dev)

Utiliser une des configurations par défaut (`environment/dev` ou `environment/validation`) ou créer une nouvelle configuration en ajoutant un nouveau répertoire dans `environment` contenant les mêmes fichiers variabilisés avec le nom de l'environnement. Pour la suite de la configuration, nous nous plaçons dans le répertoire `environment/dev`.

Déposer les fichiers d'authentification  (cf. [doc OpenStack](https://docs.openstack.org/openstacksdk/latest/user/config/configuration.html#splitting-secrets)) :

  - le fichier `secure.yaml` contenant les mots de passes d'accès à l'application dans **$HOME/.config/openstack/secure.yaml**

```yaml
clouds:
  dev:
    auth:
      username: "utilisateur@dgfip.finances.gouv.fr"
      password: "******password******"
```

  - le fichier `clouds.yaml` dans le répertoire de la configuration (`environment/dev`), le fichier suivant est un exemple de `clouds.yaml`, il est à adapter.

```yaml:
clouds:
  dev:
    auth:
      auth_url: https://nuage01.dgfip.finances.rie.gouv.fr:5000/v3
      project_id: 19b7bf0697e7430fb006b9b056dd3a27
      project_name: "DGFIP-ODIN-dev"
      user_domain_name: "Default"
    cacert: rie-ca-bundle.crt
    region_name: "RegionOne"
    interface: "public"
    identity_api_version: 3
```

Les paramètres suivants, commentés à leur valeur par défaut, sont modifiables :

| Nom du paramètre | Définition | Valeur attendue |
|:---:|:---:|:---:|
| nb_serveurs_appli | nombre de VMs appli | entier |
| nb_serveurs_bd | Nombre de VMs BDD | entier |
| use_monitoring | Activation de la supervision | booléen |
| appli_flavor_name | Gabarit des VMs appli | Type de gabarit openstack |
| bastion_flavor_name | Gabarit de la VM bastion | Type de gabarit openstack |
| bdd_flavor_name | Gabarit des VMs BDD | Type de gabarit openstack |
| haproxy_flavor_name | Gabarit de la VM reverse proxy | Type de gabarit openstack |
| monitoring_flavor_name | Gabarit de la VM de supervision | Type de gabarit openstack |
| appli_image_name | Nom de l'OS pour les VMs appli | Image linux parmi celles proposées dans openstack |
| bdd_image_name | Nom de l'OS pour les VMs BDD | Image linux parmi celles proposées dans openstack |
| bastion_image_name | Nom de l'OS pour le bastion | Image linux parmi celles proposées dans openstack |
| monitoring_image_name | Nom de l'OS pour la VM monitoring | Image linux parmi celles proposées dans openstack |
| haproxy_image_name | Nom de l'OS pour le reverse proxy | Image linux parmi celles proposées dans openstack |
| monitoring_extra_disk | Nombre de disques de stockage supplémentaires pour le monitoring | entier |
| monitoring_extra_disk_size | Taille des disques de stockage supplémentaires pour le monitoring (GO) | entier |
| bdd_extra_disk | Nombre de disques de stockage supplémentaires pour la BDD | entier |
| bdd_extra_disk_size | Taille des disques de stockage supplémentaires pour la BDD (GO) | entier |
| appli_extra_disk | Nombre de disques de stockage supplémentaires pour l'appli | entier |
| appli_extra_disk_size | Taille des disques de stockage supplémentaires pour l'appli (GO) | entier |
| fixed_haproxy_fip | Ip flottante du réseau pub | adresse ip |
| fixed_bastion_fip | Ip flottante du réseau admin | adresse ip |
| extra_admin_static_route | Routes statiques supplémentaires (en plus de celles fournies) | Liste d'adresses IP |

Modifier le fichier backend.tf en fonction des besoins (nom du cloud et des containeurs). Par défaut, le code crée 2 conteneurs swift sur nubo et les tfstates y sont stockés. Attention, les conteneurs ne sont pas supprimés automatiquement.

### Création de l'infrastructure

Une fois la configuration faite, le code terraform se lance avec les commandes suivantes depuis le répertoire racine du projet

```
terraform init --backend-config ./environments/prod/remote-state.tf
```

Attention, en cas d'erreur lors de l'initialisation du projet, veuillez ajouter la commande suivante:

```
export TF_CLI_CONFIG_FILE = <chemin-vers-le-fichier-terraformrc>
```

Ensuite pour vérifier ce qui va être fait par terraform :

```
terraform plan --var-file ./environments/prod/parameters.tfvars
```

Enfin pour procéder au déploiement :

```
terraform apply  --var-file ./environments/prod/parameters.tfvars
```

La suppression de l'environnement se fait par la commande :

```
terraform destroy  --var-file ./environments/prod/parameters.tfvars
```

