provider "aws" {
  region = "${lookup(var.Region, terraform.workspace)}"
}

terraform {
  backend "s3" {
    bucket = "dops-terraform-storage"
    key = "elasticsearch/terraform.tfstate"
    region = "eu-west-1"
  }
}
