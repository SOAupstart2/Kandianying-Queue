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

# Receiving messages
resp = sqs.receive_message({
  queue_url: queue_url, # required
  max_number_of_messages: 10,
  visibility_timeout: 1,
  wait_time_seconds: 1,
})

# Show messages. resp.messages is an array object.
resp.messages.each do |msg|
  puts msg.body

  # delete the message
  sqs.delete_message({
    queue_url: queue_url,
    receipt_handle: msg.receipt_handle
    })
end
