terraform {
  # backend "s3" {
  #   bucket  = "serhii-satanenko-terraform-state"
  #   key     = "work-terraform/cdn-final-module/terraform.tfstate"
  #   region  = "eu-central-1"
  #   encrypt = true
  # }
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "serhii-satanenko"
    # token = "w5svtBfdUGPnGQ.atlasv1.Qbmwai5F9XvItGzHyhsKIwvUd6YsodCioaOTP3wHwshVRvntZFerkvtLThoGgZQry6w"
    token = "1AbeqkmzRxAXBw.atlasv1.r0Ne3cljQt7uyzkcyaOa7V9RVt9lyaVyve6MT9qtzIIOaKuzP1Rn6GxRDSiwX114N6c"
    workspaces {
      name = "cdn-module"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.58.0"
    }
  }
}