terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.81"
    }
  }
  # Intentionally LOCAL state: this stack creates the remote backend itself.
}

provider "aws" {
  region = var.region

  default_tags {
    tags = local.tags
  }
}
