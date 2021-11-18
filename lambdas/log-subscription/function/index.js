const AWS = require('aws-sdk');
const cloudwatchLogs = new AWS.CloudWatchLogs();

exports.handler = async (event) => {
  const logGroupName = event.detail.requestParameters.logGroupName;
  // Captures the lambda name from the log group name
  // Ex: /aws/lambda/us-east-1.cloudfront-edge-viewerReq -> datadog-forwarder-cloudfront-edge-viewerReq
  const filterName = 'datadog-forwarder-' + logGroupName.match(/\.(.+)$/)[1]
  const destinationArn = process.env.datadog_forwarder_arn;

  try {
    await cloudwatchLogs.putSubscriptionFilter({
      logGroupName,
      filterName,
      destinationArn,
      filterPattern: '',
    }).promise();

    console.log('Log group %s subscribed to datadog forwarder lambda %s in %s', logGroupName, destinationArn, process.env.AWS_REGION);
    return;
  } catch (error) {
    console.error(error);
    throw error;
  }
};
