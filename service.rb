require 'json'
require 'Singleton'
require './config'
require './FriendDefinition'
require 'rest_client'
require 'sinatra'


class Service
  include Singleton
  include ConfigReader
  attr_accessor :config
    
  def initialize(config, blackMarkerConfigFile)
    puts "enter init"
    @config = getConfig(config)
    @friends = []
    @handledMessageHash = Hash.new
    puts config
    blackMarkerConfig = getConfig(blackMarkerConfigFile)
    @blackMarkerPort = blackMarkerConfig["port"]
    @blackMarkerId = blackMarkerConfig["id"]
    blackMarkerConfig["friends"].each {|friend| @friends.push(FriendDefinition.new(friend))}
    set :port, @config["port"]
    register("http://localhost:#{@blackMarkerPort}/services", JSON.generate(@config))
    puts "exit init"
  end
  
  def register(url, data)
    puts "enter register"
    puts RestClient.post(url, data)
  end
  
  def _getFriendsList()
    puts "enter _getFriendsList"
    url = "http://localhost:#{@blackMarkerPort}/neighbors"
    friends = JSON.parse(RestClient.get(url))
    puts friends
    friends
  end
  
  def _getFriendsURLList(urlSuffix)
    puts "enter _getFriendsURLList"
    friendsList = _getFriendsList()
    urlList = []
    friendsList.each{ |friend| urlList.push("#{_getFriendBaseURL(friend)}#{urlSuffix}")}
    urlList
  end
  
  def _getFriendBaseURL(friend)
    puts "enter _getFriendsBaseURL"
    "#{friend["ip"]}:#{friend["port"]}"
  end
  
  def forwardGetRequest(urlSuffix, paramHash) #param hash contains hops, origin, and message id, or nothing
    puts "enter forwardGetRequest"
    if paramHash["hops"] == nil
      puts "were starting a message"
      hops = 6
      origin = @blackMarkerId
      msgId = generateMessageId()
    elsif paramHash["hops"] == 0
      puts "no more hops"
      return []
    elsif @handledMessageHash["#{paramHash["origin"]}#{paramHash["msgId"]}"]
      puts "we've seen this message before"
      return []
    else
      puts "received message, forwarding it"
      hops = Integer(paramHash["hops"]) - 1
      origin = paramHash["origin"]
      msgId = paramHash["msgId"]
    end    
    
    @handledMessageHash["#{paramHash["origin"]}#{paramHash["msgId"]}"] = true
    
    friendURLList = _getFriendsURLList("#{urlSuffix}?hops=#{hops}&origin='#{origin}'&msgId='#{msgId}'")
    #executeGets(friendURLList)
    friendURLList
  end
  
  def executeGets(urlList)
    puts "enter executeGets"
    results = []
    urlList.each {|friendUrl| results.push(JSON.parse(RestClient.get(friendUrl)))}
    results
  end
  
  def generateMessageId()
    Time.new
  end
end
