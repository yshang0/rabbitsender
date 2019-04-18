require 'sinatra'
require 'bunny'

connection = Bunny.new ENV['CLOUDAMQP_URL']

# connection = Bunny.new(host:  'localhost',
#                   port:  '5672',
#                   vhost: '/',
#                   user:  'guest',
#                   pass:  'guest')

get '/' do
	erb :main
end

post '/sender'  do
	connection.start

	channel = connection.create_channel

	queue = channel.queue('hello')

	channel.default_exchange.publish('Hello World', routing_key: queue.name)
	puts " [x] Sent 'Hello World!'"

	connection.close

	redirect '/'
	
end

