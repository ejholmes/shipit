require 'bundler'
Bundler.require :default, :development
require 'rack/test'
require File.expand_path '../../app', __FILE__

set :environment, :test

def app
  Deployalot::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
