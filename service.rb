

class Service
  
  def serviceConfigFile
    "please override"
  end
  
  def blackMarkerConfigFile
    "please override"
  end
  
  def config()
    configuration = IO.readlines(CONFIG_FILE)
    jsonConfig = configuration.join("")
    @config = JSON.parse(jsonConfig)
    
    blackMarkerConfig = IO.readlines(BLACK_MARKER_CONFIG)
    jsonBackMarkerConfig = blackMarkerConfig.join("")
    blackMarker = JSON.parse(jsonBackMarkerConfig)
    @blackMarkerPort = blackMarker["port"]
  end
end