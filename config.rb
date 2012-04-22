require 'json'

class FriendDefinition
  attr_accessor :id, :ip, :port
  
  def initialize(hash)
    @id = hash["id"]
    @ip = hash["ip"]
    @port = hash["port"]
  end
  
end

class ReachoutConfig
  attr_accessor :id, :friends, :port

  def initialize(filename)
    configuration = IO.readlines(filename)
    jsonConfig = configuration.join("")
    config = JSON.parse(jsonConfig)
    @id = config["id"]
    @friends = []
    config["friends"].each {|friend| @friends.push(FriendDefinition.new(friend))}
    @port = config["port"]
  end
  
end