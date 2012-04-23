require './config'

require 'sinatra'
require 'singleton'
require 'json'
require 'rest_client'


class FriendDefinition
  attr_accessor :id, :ip, :port
  
  def initialize(hash)
    @id = hash["id"]
    @ip = hash["ip"]
    @port = hash["port"]
  end
  
  def to_json(*a)
    {
      "id" => @id,
      "ip" => @ip,
      "port" => @port
    }.to_json(*a)
  end
  
end

class BlackMarker
  include Singleton
  include ConfigReader
  
  @@CONFIG_FILE = "blackMarker.config"

  attr_accessor :services, :id, :port, :friends
  
  def initialize()
    @services = Hash.new
    @configHash = getConfig(@@CONFIG_FILE)
    @id = @configHash['id']
    @port = @configHash['port']
    @friends = []
    @configHash["friends"].each {|friend| @friends.push(FriendDefinition.new(friend))}
  end
  
end

def main(args)
  router = BlackMarker.instance
  set :port, router.port
end

if __FILE__ == $0
  main(ARGV)
end


post '/service' do
  #a service will make itself known here
  #request.body.read
  service = JSON.parse(request.body.read)
  head = BlackMarker.instance
  head.services[service["urlPrefix"]] = service["port"]
  JSON.generate head.services
end

get '/service' do
  head = BlackMarker.instance
  JSON.generate(head.services)
end

get '/friends' do
  router = BlackMarker.instance
  JSON.generate(router.friends)
end


get '/:servicePrefix/*' do
  router = BlackMarker.instance
  prefix = params[:servicePrefix]
  if router.services.has_key?(prefix)
    port = router.services[prefix]
    sp = params[:splat][0] #[0] because splat param returns an array to support multiple splats
    RestClient.get("http://localhost:#{port}/#{prefix}/#{sp}")
  end
end

post '/:servicePrefix/*' do
  
end

put '/:servicePrefix/*' do
  
end

patch '/:servicePrefix/*' do
  
end

delete '/:servicePrefix/*' do
  
end

options '/:servicePrefix/*' do
  
end

post '/*' do
  
end

post '/*' do
  
end

put '/*' do
  
end

patch '/*' do
  
end

delete '/*' do
  
end

options '/*' do
  
end



