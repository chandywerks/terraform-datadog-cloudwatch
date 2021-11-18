variable "region" {
  type = string
}

variable "ddApiKeySecretName" {
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
