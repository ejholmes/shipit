ENV["RACK_ENV"] = "test"

require "mocha"
require "rack/test"

require "shipit"
Shipit.setup(ENV)

def app
  Shipit.app
end

RSpec.configure do |config|
  config.before(:each) do
    Shipit::Job.any_instance.stubs(:clone).returns(nil)
  end
end
