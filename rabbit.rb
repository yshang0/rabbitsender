require 'bunny'

connection = Bunny.new ENV['CLOUDAMQP_URL']
connection.start

channel = connection.create_channel

queue = channel.queue('hello')

channel.default_exchange.publish('Hello World', routing_key: queue.name)
puts " [x] Sent 'Hello World!'"

connection.close


# ENV['CLOUDAMQP_URL']


# (host:  'localhost',
#                   port:  '5672',
#                   vhost: '/',
#                   user:  'guest',
#                   pass:  'guest')