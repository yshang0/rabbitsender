require 'bunny'

connection = Bunny.new(host:  'localhost',
                  port:  '5672',
                  vhost: '/',
                  user:  'guest',
                  pass:  'guest')
connection.start

channel = connection.create_channel

queue = channel.queue('hello')

channel.default_exchange.publish('Hello World', routing_key: queue.name)
puts " [x] Sent 'Hello World!'"

connection.close


# ENV['CLOUDAMQP_URL']