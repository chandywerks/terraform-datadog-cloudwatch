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

// Lambda assume role policy
data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    effect = "Allow"
  }
}

// Log subscription lambda role
resource "aws_iam_role" "log_subscription_lambda_role" {
  name = "log-subscription-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

// Log subscription lambda policy
resource "aws_iam_role_policy" "log_subscription_lambda_policy" {
  name = "log-subscription-lambda-policy"
  role = aws_iam_role.log_subscription_lambda_role.id
  policy = file("lambdas/log-subscription/role-policy.json")
}

// Log subscription lambda package zip
data "archive_file" "log_subscription_package" {
  type = "zip"
  source_dir = "lambdas/log-subscription/function"
  output_path = "/tmp/log-subscription.zip"
}

// Log retention lambda role
resource "aws_iam_role" "log_retention_lambda_role" {
  name = "log-retention-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

// Log retention lambda policy
resource "aws_iam_role_policy" "log_retention_lambda_policy" {
  name = "log-retention-lambda-policy"
  role = aws_iam_role.log_retention_lambda_role.id
  policy = file("lambdas/log-retention/role-policy.json")
}

// Log retention lambda package zip
data "archive_file" "log_retention_package" {
  type = "zip"
  source_dir = "lambdas/log-retention/function"
  output_path = "/tmp/log-retention.zip"
}

// North America
module "us-east-1" {
  source = "./lambdas"
  region = "us-east-1"
  ddApiKeySecretName = var.ddApiKeySecretName
  logSubscriptionLambdaHash = data.archive_file.log_subscription_package.output_base64sha256
  logSubscriptionLambdaRoleArn = aws_iam_role.log_subscription_lambda_role.arn
}

module "us-east-2" {
  source = "./lambdas"
  region = "us-east-2"
  ddApiKeySecretName = var.ddApiKeySecretName
  logSubscriptionLambdaHash = data.archive_file.log_subscription_package.output_base64sha256
  logSubscriptionLambdaRoleArn = aws_iam_role.log_subscription_lambda_role.arn
}

module "us-west-1" {
  source = "./lambdas"
  region = "us-west-1"
  ddApiKeySecretName = var.ddApiKeySecretName
  logSubscriptionLambdaHash = data.archive_file.log_subscription_package.output_base64sha256
  logSubscriptionLambdaRoleArn = aws_iam_role.log_subscription_lambda_role.arn
}

module "us-west-2" {
  source = "./lambdas"
  region = "us-west-2"
  ddApiKeySecretName = var.ddApiKeySecretName
  logSubscriptionLambdaHash = data.archive_file.log_subscription_package.output_base64sha256
  logSubscriptionLambdaRoleArn = aws_iam_role.log_subscription_lambda_role.arn
}

module "ca-central-1" {
  source = "./lambdas"
  region = "ca-central-1"
  ddApiKeySecretName = var.ddApiKeySecretName
  logSubscriptionLambdaHash = data.archive_file.log_subscription_package.output_base64sha256
  logSubscriptionLambdaRoleArn = aws_iam_role.log_subscription_lambda_role.arn
}

// South America

module "sa-east-1" {
  source = "./lambdas"
  region = "sa-east-1"
  ddApiKeySecretName = var.ddApiKeySecretName
  logSubscriptionLambdaHash = data.archive_file.log_subscription_package.output_base64sha256
  logSubscriptionLambdaRoleArn = aws_iam_role.log_subscription_lambda_role.arn
}

// Europe

module "eu-central-1" {
  source = "./lambdas"
  region = "eu-central-1"
  ddApiKeySecretName = var.ddApiKeySecretName
  logSubscriptionLambdaHash = data.archive_file.log_subscription_package.output_base64sha256
  logSubscriptionLambdaRoleArn = aws_iam_role.log_subscription_lambda_role.arn
}

module "eu-west-1" {
  source = "./lambdas"
  region = "eu-west-1"
  ddApiKeySecretName = var.ddApiKeySecretName
  logSubscriptionLambdaHash = data.archive_file.log_subscription_package.output_base64sha256
  logSubscriptionLambdaRoleArn = aws_iam_role.log_subscription_lambda_role.arn
}

module "eu-west-2" {
  source = "./lambdas"
  region = "eu-west-2"
  ddApiKeySecretName = var.ddApiKeySecretName
  logSubscriptionLambdaHash = data.archive_file.log_subscription_package.output_base64sha256
  logSubscriptionLambdaRoleArn = aws_iam_role.log_subscription_lambda_role.arn
}

module "eu-west-3" {
  source = "./lambdas"
  region = "eu-west-3"
  ddApiKeySecretName = var.ddApiKeySecretName
  logSubscriptionLambdaHash = data.archive_file.log_subscription_package.output_base64sha256
  logSubscriptionLambdaRoleArn = aws_iam_role.log_subscription_lambda_role.arn
}

module "eu-north-1" {
  source = "./lambdas"
  region = "eu-north-1"
  ddApiKeySecretName = var.ddApiKeySecretName
  logSubscriptionLambdaHash = data.archive_file.log_subscription_package.output_base64sha256
  logSubscriptionLambdaRoleArn = aws_iam_role.log_subscription_lambda_role.arn
}

// Asia Pacific

module "ap-south-1" {
  source = "./lambdas"
  region = "ap-south-1"
  ddApiKeySecretName = var.ddApiKeySecretName
  logSubscriptionLambdaHash = data.archive_file.log_subscription_package.output_base64sha256
  logSubscriptionLambdaRoleArn = aws_iam_role.log_subscription_lambda_role.arn
}

module "ap-northeast-2" {
  source = "./lambdas"
  region = "ap-northeast-2"
  ddApiKeySecretName = var.ddApiKeySecretName
  logSubscriptionLambdaHash = data.archive_file.log_subscription_package.output_base64sha256
  logSubscriptionLambdaRoleArn = aws_iam_role.log_subscription_lambda_role.arn
}

module "ap-southeast-1" {
  source = "./lambdas"
  region = "ap-southeast-1"
  ddApiKeySecretName = var.ddApiKeySecretName
  logSubscriptionLambdaHash = data.archive_file.log_subscription_package.output_base64sha256
  logSubscriptionLambdaRoleArn = aws_iam_role.log_subscription_lambda_role.arn
}

module "ap-southeast-2" {
  source = "./lambdas"
  region = "ap-southeast-2"
  ddApiKeySecretName = var.ddApiKeySecretName
  logSubscriptionLambdaHash = data.archive_file.log_subscription_package.output_base64sha256
  logSubscriptionLambdaRoleArn = aws_iam_role.log_subscription_lambda_role.arn
}

module "ap-northeast-1" {
  source = "./lambdas"
  region = "ap-northeast-1"
  ddApiKeySecretName = var.ddApiKeySecretName
  logSubscriptionLambdaHash = data.archive_file.log_subscription_package.output_base64sha256
  logSubscriptionLambdaRoleArn = aws_iam_role.log_subscription_lambda_role.arn
}
