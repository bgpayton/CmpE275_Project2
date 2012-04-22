require './config'
require 'sinatra'
require 'singleton'
require 'json'
require 'rest_client'


CONFIG_FILE = "blackMarker.config"

class BlackMarker
  include Singleton
    attr_accessor :services

  
  def initialize()
    @services = Hash.new
  end
end

@mainConfig = nil
def getConfig()
  if @mainConfig == nil
    @mainConfig = ReachoutConfig.new(CONFIG_FILE)
  end
  @mainConfig
end

def main(args)
  cfg = getConfig
  set :port, cfg.port
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

if __FILE__ == $0
  main(ARGV)
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



