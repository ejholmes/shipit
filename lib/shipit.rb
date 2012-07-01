require "active_record"
require "sinatra/base"
require "open3"

require "shipit/version"
require "shipit/app"

require "shipit/repository"
require "shipit/environment"
require "shipit/job"

module Shipit
  class << self
    def setup(settings)
      env = settings["RACK_ENV"]
      if env.nil? || env.empty?
        raise Error, "RACK_ENV is required"
      end

      if env != "production"
        settings["DATABASE_URL"] ||= "mysql2://root@localhost/shipit_#{env}"
      end

      database = URI(settings["DATABASE_URL"])
      adapter  = database.scheme == "postgres" ? "postgresql" : database.scheme

      connection = {
        :adapter   => adapter,
        :host      => database.host,
        :database  => database.path[1..-1],
        :username  => database.user,
        :password  => database.password,
        :reconnect => true,
      }
      ActiveRecord::Base.establish_connection(connection)
    end

    def app
      @app ||= Rack::Builder.new {
        run Shipit::App
      }
    end

    def enable_mock!
      Job.enable_mock!
    end
  end
end
