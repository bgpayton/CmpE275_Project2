require 'sinatra'
require 'singleton'
require 'rest_client'
require 'json'


CONFIG_FILE = "hands.config"
BLACK_MARKER_CONFIG = "blackMarker.config"

class Hands
  include Singleton
  attr_accessor :config
  
  def initialize()
    configuration = IO.readlines(CONFIG_FILE)
    jsonConfig = configuration.join("")
    @config = JSON.parse(jsonConfig)
    
    blackMarkerConfig = IO.readlines(BLACK_MARKER_CONFIG)
    jsonBackMarkerConfig = blackMarkerConfig.join("")
    blackMarker = JSON.parse(jsonBackMarkerConfig)
    @blackMarkerPort = blackMarker["port"]
  end
  
  def register()
    puts RestClient.post("http://localhost:#{@blackMarkerPort}/service", JSON.generate(@config))
  end
end



def main(args)
  hands = Hands.instance
  set :port, hands.config["port"]
  hands.register
end


if __FILE__ == $0
  main(ARGV)
end


get '/hands' do
  "hands"
end

get '/hands/mentors/' do
  #return a list of available mentors
end

post '/hands/mentors/' do
  #return a list of charities
end

post '/hands/mentors/:nodeId/:mentorId/messages' do
  #adds a new message for a mentor
end

get '/hands/mentors/:mentorId/messages' do
  #get messages for a mentor
end

get '/hands/*' do
  params[:splat][0]
end







