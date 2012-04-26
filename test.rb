require 'rest_client'
require 'JSON'

#puts RestClient.post('http://localhost:9000/service', "{\"test\":\"test2\"}")

test = Hash.new
test['urlPrefix'] = 'hands'
test['port'] = "9001"


puts RestClient.post('http://localhost:9000/service', JSON.generate(test))


puts RestClient.get('http://localhost:9000/hands/hello')
