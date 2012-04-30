require 'sinatra'
require './service'


class Hands < Service
  @@CONFIG_FILE = "hands.config"
  @@BLACK_MARKER_CONFIG = "blackMarker.config"
  
  def initialize()
    super(@@CONFIG_FILE, @@BLACK_MARKER_CONFIG)
  end
  
end


def main(args)
  hands = Hands.instance
  #puts hands.forwardGetRequest('/hands/mentors', {"hops" => 4, "msgId"=>"test", "origin"=>"testOrigin"})
  #puts hands.forwardGetRequest('/hands/mentors', {})
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
  
  hands = Hands.instance
  result = hands.forwardGetRequest(env["PATH_INFO"], {"hops" => params["hops"], "msgId" => params["msgId"], "origin" => params["origin"]})
  result.push("this is my result")
  result
end







