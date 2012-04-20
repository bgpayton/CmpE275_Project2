require 'sinatra'
require 'mongo'

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







