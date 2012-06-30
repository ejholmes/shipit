ENV["RACK_ENV"] = "test"

require "rspec"
require "mocha"
require "rack/test"

require "shipit"
Shipit.setup(ENV)

def app
  Shipit.app
end

Shipit.enable_mock!
