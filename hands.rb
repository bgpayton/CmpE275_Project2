
require './service'
require 'sinatra'


class Hands < Service
  @@CONFIG_FILE = "hands.config"
  @@BLACK_MARKER_CONFIG = "blackMarker.config"
  
  def initialize()
    super(@@CONFIG_FILE, @@BLACK_MARKER_CONFIG)
  end
  
end


def main(args)
  hands = Hands.instance
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







