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

variable "ddApiKeySecretArn" {
  type = string
}

// North America
module "us-east-1" {
  source = "./lambdas"
  region = "us-east-1"
  ddApiKeySecretArn = var.ddApiKeySecretArn
}

module "us-east-2" {
  source = "./lambdas"
  region = "us-east-2"
  ddApiKeySecretArn = var.ddApiKeySecretArn
}

module "us-west-1" {
  source = "./lambdas"
  region = "us-west-1"
  ddApiKeySecretArn = var.ddApiKeySecretArn
}

module "us-west-2" {
  source = "./lambdas"
  region = "us-west-2"
  ddApiKeySecretArn = var.ddApiKeySecretArn
}

module "ca-central-1" {
  source = "./lambdas"
  region = "ca-central-1"
  ddApiKeySecretArn = var.ddApiKeySecretArn
}

// South America

module "sa-east-1" {
  source = "./lambdas"
  region = "sa-east-1"
  ddApiKeySecretArn = var.ddApiKeySecretArn
}

// Europe

module "eu-central-1" {
  source = "./lambdas"
  region = "eu-central-1"
  ddApiKeySecretArn = var.ddApiKeySecretArn
}

module "eu-west-1" {
  source = "./lambdas"
  region = "eu-west-1"
  ddApiKeySecretArn = var.ddApiKeySecretArn
}

module "eu-west-2" {
  source = "./lambdas"
  region = "eu-west-2"
  ddApiKeySecretArn = var.ddApiKeySecretArn
}

module "eu-west-3" {
  source = "./lambdas"
  region = "eu-west-3"
  ddApiKeySecretArn = var.ddApiKeySecretArn
}

module "eu-north-1" {
  source = "./lambdas"
  region = "eu-north-1"
  ddApiKeySecretArn = var.ddApiKeySecretArn
}

// Asia Pacific

module "ap-south-1" {
  source = "./lambdas"
  region = "ap-south-1"
  ddApiKeySecretArn = var.ddApiKeySecretArn
}

module "ap-northeast-2" {
  source = "./lambdas"
  region = "ap-northeast-2"
  ddApiKeySecretArn = var.ddApiKeySecretArn
}

module "ap-southeast-1" {
  source = "./lambdas"
  region = "ap-southeast-1"
  ddApiKeySecretArn = var.ddApiKeySecretArn
}

module "ap-southeast-2" {
  source = "./lambdas"
  region = "ap-southeast-2"
  ddApiKeySecretArn = var.ddApiKeySecretArn
}

module "ap-northeast-1" {
  source = "./lambdas"
  region = "ap-northeast-1"
  ddApiKeySecretArn = var.ddApiKeySecretArn
}
