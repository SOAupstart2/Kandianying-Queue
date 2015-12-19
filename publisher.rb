require 'aws-sdk'
require 'yaml'

# Load keys
keys = YAML.load(File.read('config/aws_keys.yml'))

#Set credentials
credentials = Aws::Credentials.new(keys['sqs']['AWS_ACCESS_KEY_ID'], keys['sqs']['AWS_SECRET_ACCESS_KEY'])

#Initialization
sqs = Aws::SQS::Client.new(
  region: keys['sqs']['AWS_REGION'],
  credentials: credentials,
)

# Set url and message
queue_url = keys['sqs']['AWS_URL']
queue_msg = []

5.times do
  queue_msg << 'test kandianying'
end

#Send message
queue_msg.each do |msg|
  sqs.send_message({
    queue_url: queue_url,
    message_body: msg,
    message_attributes: {
      "String" => {
        string_value: "String",
        data_type: "String",
      },
    },
  })
end
