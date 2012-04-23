require 'json'


module ConfigReader
  def getConfig(filename)
    configuration = IO.readlines(filename)
    jsonConfig = configuration.join("")
    JSON.parse(jsonConfig)
  end
end