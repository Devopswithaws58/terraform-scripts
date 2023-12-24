terraform {
  required_providers {
    aws = {
      source = "hasicorp/aws"
      version = "5.31.0"
    }
  }
}
provider "aws" {
  region = "ap-south-1"
}