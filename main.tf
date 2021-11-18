// TODO configure region as variable
provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    key    = "datadog-cloudwatch"
    region = "us-east-1"
  }
}

variable "ddApiKeySecretName" {
  type = string
}

// North America
module "us-east-1" {
  source = "./lambdas"
  region = "us-east-1"
  ddApiKeySecretName = var.ddApiKeySecretName
}

module "us-east-2" {
  source = "./lambdas"
  region = "us-east-2"
  ddApiKeySecretName = var.ddApiKeySecretName
}

module "us-west-1" {
  source = "./lambdas"
  region = "us-west-1"
  ddApiKeySecretName = var.ddApiKeySecretName
}

module "us-west-2" {
  source = "./lambdas"
  region = "us-west-2"
  ddApiKeySecretName = var.ddApiKeySecretName
}

module "ca-central-1" {
  source = "./lambdas"
  region = "ca-central-1"
  ddApiKeySecretName = var.ddApiKeySecretName
}

// South America

module "sa-east-1" {
  source = "./lambdas"
  region = "sa-east-1"
  ddApiKeySecretName = var.ddApiKeySecretName
}

// Europe

module "eu-central-1" {
  source = "./lambdas"
  region = "eu-central-1"
  ddApiKeySecretName = var.ddApiKeySecretName
}

module "eu-west-1" {
  source = "./lambdas"
  region = "eu-west-1"
  ddApiKeySecretName = var.ddApiKeySecretName
}

module "eu-west-2" {
  source = "./lambdas"
  region = "eu-west-2"
  ddApiKeySecretName = var.ddApiKeySecretName
}

module "eu-west-3" {
  source = "./lambdas"
  region = "eu-west-3"
  ddApiKeySecretName = var.ddApiKeySecretName
}

module "eu-north-1" {
  source = "./lambdas"
  region = "eu-north-1"
  ddApiKeySecretName = var.ddApiKeySecretName
}

// Asia Pacific

module "ap-south-1" {
  source = "./lambdas"
  region = "ap-south-1"
  ddApiKeySecretName = var.ddApiKeySecretName
}

module "ap-northeast-2" {
  source = "./lambdas"
  region = "ap-northeast-2"
  ddApiKeySecretName = var.ddApiKeySecretName
}

module "ap-southeast-1" {
  source = "./lambdas"
  region = "ap-southeast-1"
  ddApiKeySecretName = var.ddApiKeySecretName
}

module "ap-southeast-2" {
  source = "./lambdas"
  region = "ap-southeast-2"
  ddApiKeySecretName = var.ddApiKeySecretName
}

module "ap-northeast-1" {
  source = "./lambdas"
  region = "ap-northeast-1"
  ddApiKeySecretName = var.ddApiKeySecretName
}
