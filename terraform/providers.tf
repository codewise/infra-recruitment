terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">3.50.0"
      configuration_aliases = [ aws, aws.certificate ]
    }
  }
}
