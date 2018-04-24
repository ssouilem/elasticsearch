variable "AmiLinux" {
  type = "map"
  default = {
    eu-west-1    = "ami-405f7226"
    eu-central-1 = "ami-3f1bd150"
    eu-west-3    = "ami-0e55e373"
  }
  description = "I add only 2 regions (Ireland, Francfort) to show the map feature but you can add all the r"
}

variable "key_name" {
  default = "claptrap"
  description = "Clé SSH à utiliser"
}

variable "nodes"                 { default=2 }
variable "Domaine"               { type = "map" }
variable "Region"                { type = "map" }
variable "Projet"                { type = "map" }
variable "Roles"                 { type = "map" }
variable "DnsZoneName"           { type = "map" }
variable "VMSize"                { type = "map" }
variable "Env"                   { type = "map" }
variable "Nameint"               { type = "map" }
variable "Alwayson"              { type = "map" }
variable "Patch"                 { type = "map" }
variable "Monitored"             { type = "map" }
variable "DopsInstancePolicyArn" { type = "map" }

