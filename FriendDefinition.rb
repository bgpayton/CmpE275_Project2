require 'json'

class FriendDefinition
  attr_accessor :id, :ip, :port
  
  def initialize(hash)
    puts "hash"
    puts hash
    @id = hash["id"]
    @ip = hash["ip"]
    @port = hash["port"]
  end
  
  def to_json(*a)
    {
      "id" => @id,
      "ip" => @ip,
      "port" => @port
    }.to_json(*a)
  end
  
  def getURL(suffix)
    "http://#{@ip}:#{@port}#{suffix}"
  end  
end