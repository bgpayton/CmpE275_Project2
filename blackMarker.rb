require './config'
require './FriendDefinition'

require 'sinatra'
require 'singleton'
require 'json'
require 'rest_client'

DEFAULT_HOPS = 6 #Kevin Bacon

class BlackMarker
  include Singleton
  include ConfigReader
  
  @@CONFIG_FILE = "blackMarker.config"

  attr_accessor :services, :id, :port, :friends
  
  def setConfig(file)
    @configHash = getConfig(file)
    @id = @configHash['id']
    puts @configHash
    @port = @configHash['port']
    @friends = []
    @configHash["friends"].each {|friend| @friends.push(FriendDefinition.new(friend))}
  end
  
  def initialize()
    @services = Hash.new
    setConfig(@@CONFIG_FILE)
  end
  
  def handleGetHops(url, hops, data)
    puts "#{url}?hops=${hops-1}"
  end
  
  def doGets(urlList)
    resultList = urlList.each{|url| doGet(url)}
    #urlList
  end
  
  def doGet(url)
    JSON.parse(RestClient.get(url))
  end
  
  def generateMessageId()
    Time.new
  end
end

def main(args)
  router = BlackMarker.instance()
  puts args[0]
  if(args.size != 0) #specify an alternative config file
    router.setConfig(args[0])
  end
  set :port, router.port
end

if __FILE__ == $0
  main(ARGV)
end


post '/services' do
  #a service will make itself known here
  #request.body.read
  service = JSON.parse(request.body.read)
  head = BlackMarker.instance
  head.services[service["name"]] = service["port"]
  JSON.generate head.services
end

get '/services' do
  head = BlackMarker.instance
  JSON.generate(head.services)
end

get '/neighbors' do
  router = BlackMarker.instance
  JSON.generate(router.friends)
end



get '/:servicePrefix/*' do

  router = BlackMarker.instance
  prefix = params[:servicePrefix]
  if router.services.has_key?(prefix)
    port = router.services[prefix]
    sp = params[:splat][0] #[0] because splat param returns an array to support multiple splats
    selfUrl = "http://localhost:#{port}/#{prefix}/#{sp}"
    puts "forwarding to #{selfUrl}"
    return RestClient.get(selfUrl)
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



