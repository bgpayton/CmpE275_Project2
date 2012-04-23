require './service'
require 'sinatra'


class Hands < Service
  @@CONFIG_FILE = "hearts.config"
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



get '/hearts/charities/' do
  #check neighbors max hops = 
  #return a list of charities
  
end

post '/hearts/charities' do
  #add a charity
end

delete '/hearts/charities' do
  #remove a charity
end

get '/hearts/charities/:name' do
  #return info about :name charity
  params[:name]
end

get '/hearts/charities/:name/*' do
  
end