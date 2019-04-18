# require 'sinatra'
# require 'bunny'

# connection = Bunny.new ENV['CLOUDAMQP_URL']

# # connection = Bunny.new(host:  'localhost',
# #                   port:  '5672',
# #                   vhost: '/',
# #                   user:  'guest',
# #                   pass:  'guest')

# get '/' do
# 	erb :main
# end

# post '/sender'  do
# 	connection.start

# 	channel = connection.create_channel

# 	queue = channel.queue('hello')

# 	channel.default_exchange.publish('Hello World', routing_key: queue.name)
# 	puts " [x] Sent 'Hello World!'"

# 	connection.close

# 	redirect '/'
	
# end

require 'sinatra'
require 'sinatra/streaming'
require 'haml'
require 'amqp'

configure do
  disable :logging
  EM.next_tick do
    # Connect to CloudAMQP and set the default connection
    url = ENV['CLOUDAMQP_URL'] || "amqp://guest:guest@localhost"
    AMQP.connection = AMQP.connect url
    PUB_CHAN = AMQP::Channel.new
  end
end

get '/' do
  haml :main
end

post '/publish' do
  # publish a message to a fanout exchange
  PUB_CHAN.fanout("f1").publish "Hello, world!"
  204
end





