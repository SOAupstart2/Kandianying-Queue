require 'aws-sdk'
require 'yaml'

# Load keys
keys = YAML.load(File.read('config/aws_key.yml'))

# puts keys['production']['AWS_ACCESS_KEY_ID']
# puts keys['production']['AWS_SECRET_ACCESS_KEY']
# puts keys['production']['AWS_REGION']
# puts keys['production']['AWS_URL']

#Set credentials
credentials = Aws::Credentials.new(keys['production']['AWS_ACCESS_KEY_ID'], keys['production']['AWS_SECRET_ACCESS_KEY'])

#Initialization
sqs = Aws::SQS::Client.new(
  region: keys['production']['AWS_REGION'],
  credentials: credentials,
)

#Send message
sqs.send_message({
  queue_url: keys['production']['AWS_URL'],
  message_body: 'test kandianying',
  message_attributes: {
    "String" => {
      data_type: "String"
    },
  },
})
