require 'aws-sdk'
require 'yaml'

# Load keys
keys = YAML.load(File.read('config/aws_key.yml'))

#Set credentials
credentials = Aws::Credentials.new(keys['sqs']['AWS_ACCESS_KEY_ID'], keys['sqs']['AWS_SECRET_ACCESS_KEY'])

#Initialization
sqs = Aws::SQS::Client.new(
  region: keys['sqs']['AWS_REGION'],
  credentials: credentials,
)

# Set url and message
queue_msg = 'test kandianying'
queue_url = keys['sqs']['AWS_URL']

#Send message
sqs.send_message({
  queue_url: queue_url,
  message_body: queue_msg,
  message_attributes: {
    "String" => {
      string_value: "String",
      data_type: "String",
    },
  },
})
