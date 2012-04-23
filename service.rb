require 'json'
require 'Singleton'
require './config'
require 'rest_client'


class Service
  include Singleton
  include ConfigReader
  attr_accessor :config
    
  def initialize(config, blackMarkerConfigFile)
    @config = getConfig(config)
    puts config
    blackMarkerConfig = getConfig(blackMarkerConfigFile)
    @blackMarkerPort = blackMarkerConfig["port"]
    set :port, @config["port"]
    register("http://localhost:#{@blackMarkerPort}/service", JSON.generate(@config))
  end
  
  def register(url, data)
    puts RestClient.post(url, data)
  end
end
  