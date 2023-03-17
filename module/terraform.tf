provider "aws" {
  region  = var.region
}

variable "region" {
  default = "eu-central-1"
}