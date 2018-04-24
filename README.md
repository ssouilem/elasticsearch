# Table des matières
1. [Etat du pipeline](#cicd)
2. [Description du projet](#desc)
3. [Détail du projet](#details)
    1. [Organisation du dépot](#org)
    2. [Description des fchiers](#fdesc)

# Etat du pipeline <a name="cicd"></a>
|Environnement|Pipeline|Coverage|
|---|---|---|
|Production    |[![pipeline status](https://middleearth.dops.open.global/dops/outils/elasticsearch/badges/master/pipeline.svg)](https://middleearth.dops.open.global/dops/outils/elasticsearch/commits/master)||
|Développement |[![pipeline status](https://middleearth.dops.open.global/dops/outils/elasticsearch/badges/dev/pipeline.svg)](https://middleearth.dops.open.global/dops/outils/elasticsearch/commits/dev)||




# Description du projet <a name="desc"></a>
Ce projet est le projet terraform+ansible pour la mise en place d'une plateforme elasticsearch


# Détail du projet <a name="details"></a>
Ce projet est composé d'une partie "infra" (Terraform) et d'une partie application (Ansible), le tout piloté par Gitlab-CI

## .gitlab-ci.yml
Contient la liste des actions automatiquement lancée par gitlab au moment d'un push.
1. Vérification de la cible pour la génération et la mise à jour du tfstate utilisé par terraform
2. Initialisation de Terraform & planification des modifications
3. Application des modifications (se fait manuellement)

## variables.json

Ce fichier regroupe des informations qui peuvent être partagées en Ansible et Terraform.
Il décrit différents paramètres propres à chaque environnement ("master" pour la prod et "dev" pour le dev)

## Terraform
### 00 - variables.tf
Contient la liste des variables nécéssaire au bon déroulement des actions terraform.

### 01 - provider.tf
Défini le fournisseur d'infrastructure utilisé, ainsi que l'espace de stockage s3 utilisé pour le fichier tfstate

### 2 - data.tf
Contient les données nécessaires à la bonne intégration de ce projet au sein de l'environnement existant chez le fournisseur

### 5 - security-groups.tf
Décris les groupes de sécurité additionnels créés par le projet

### 6 - instances.tf
Décris les instances additionnelles créés par le projet

### 8 - r53.tf
Décris les entrées DNS créés par le projet


## Ansible

* [Role mongodb](ansible/local-roles/elasticsearch/README.md)
