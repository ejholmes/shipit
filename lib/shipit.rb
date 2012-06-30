require "active_record"
require "sinatra/base"

require "shipit/version"
require "shipit/app"

module Shipit
  class << self
    def app
      @app ||= Rack::Builder.new {
        run Shipit::App
      }
    end
  end
end
