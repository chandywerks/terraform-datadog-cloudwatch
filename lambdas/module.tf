variable "region" {
  type = string
}

variable "ddApiKeySecretArn" {
  type = string
}

provider "aws" {
  region = var.region
}

// Datadog forwarder lambda

resource "aws_cloudformation_stack" "datadog_forwarder" {
  name         = "datadog-forwarder"
  capabilities = ["CAPABILITY_IAM", "CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND"]
  parameters   = {
    DdApiKey           = "this_value_is_not_used"
    DdApiKeySecretArn  = "${var.ddApiKeySecretArn}"
    FunctionName       = "datadog-forwarder"
  }
  template_url = "https://datadog-cloudformation-template.s3.amazonaws.com/aws/forwarder/latest.yaml"
}
