variable "region" {
  type = string
}

variable "ddApiKeySecretName" {
  type = string
}

variable "logSubscriptionLambdaRoleArn" {
  type = string
}

variable "logSubscriptionLambdaHash" {
  type = string
}

variable "logRetentionLambdaRoleArn" {
  type = string
}

variable "logRetentionLambdaHash" {
  type = string
}

provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}

// Datadog forwarder lambda

resource "aws_cloudformation_stack" "datadog_forwarder" {
  name         = "datadog-forwarder"
  capabilities = ["CAPABILITY_IAM", "CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND"]
  parameters   = {
    DdApiKey           = "this_value_is_not_used"
    DdApiKeySecretArn  = "arn:aws:secretsmanager:${var.region}:${data.aws_caller_identity.current.account_id}:secret:${var.ddApiKeySecretName}"
    FunctionName       = "datadog-forwarder"
  }
  template_url = "https://datadog-cloudformation-template.s3.amazonaws.com/aws/forwarder/latest.yaml"
}

// Log group created cloudwatch event bridge rule
resource "aws_cloudwatch_event_rule" "create_log_group_event" {
  name = "log-group-created"
  description = "Event bridge trigger for a newly created log group"
  event_pattern = file("lambdas/log-group-created-event-pattern.json")
}

// Log group forwarder subscription lambda
resource "aws_lambda_function" "log_subscription" {
  filename = "/tmp/log-subscription.zip"
  source_code_hash = var.logSubscriptionLambdaHash
  function_name = "log-subscription"
  role = var.logSubscriptionLambdaRoleArn
  description = "Subscribe log group to the datadog-forwarder lambda when created"
  handler = "index.handler"
  runtime = "nodejs14.x"

  environment {
    variables = {
      datadog_forwarder_arn = aws_cloudformation_stack.datadog_forwarder.outputs.DatadogForwarderArn
    }
  }
}

resource "aws_cloudwatch_event_target" "create_log_group_subscription_trigger" {
  rule = aws_cloudwatch_event_rule.create_log_group_event.name
  target_id = "log_subscription"
  arn = aws_lambda_function.log_subscription.arn
}

resource "aws_lambda_permission" "create_log_group_subscription_permission" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.log_subscription.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.create_log_group_event.arn
}

// Log group retention lambda
resource "aws_lambda_function" "log_retention" {
  filename = "/tmp/log-retention.zip"
  source_code_hash = var.logRetentionLambdaHash
  function_name = "log-retention"
  role = var.logRetentionLambdaRoleArn
  description = "Sets retention time on cloudwatch log groups when created"
  handler = "index.handler"
  runtime = "nodejs14.x"
}

resource "aws_cloudwatch_event_target" "create_log_group_event_trigger" {
  rule = aws_cloudwatch_event_rule.create_log_group_event.name
  target_id = "log_retention"
  arn = aws_lambda_function.log_retention.arn
}

resource "aws_lambda_permission" "create_log_group_event_permission" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.log_retention.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.create_log_group_event.arn
}
