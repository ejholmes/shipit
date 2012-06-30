ENV["RACK_ENV"] = "test"

require "rack/test"

require "shipit"
Shipit.setup(ENV)

def app
  Shipit.app
end
