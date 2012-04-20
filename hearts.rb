require 'sinatra'
require 'mongo'

get '/hearts/charities/' do
  #check neighbors max hops = 
  #return a list of charities
  
end

get '/hearts/charities/:hops' do
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