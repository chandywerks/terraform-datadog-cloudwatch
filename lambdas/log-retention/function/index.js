const AWS = require('aws-sdk');
const cloudwatchLogs = new AWS.CloudWatchLogs();

// Retain logs in cloudwatch for 1 week
const retentionInDays = 14;

exports.handler = async (event) => {
  const logGroupName = event.detail.requestParameters.logGroupName;

  try {
    const params = {
      logGroupName,
      retentionInDays,
    };

    await cloudwatchLogs.putRetentionPolicy(params).promise();

    console.log('Log group %s retention set to %s days in %s', logGroupName, retentionInDays, process.env.AWS_REGION);
    return;
  } catch (error) {
    console.error(error);
    throw error;
  }
};
