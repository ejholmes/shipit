module Shipit
  class App < Sinatra::Base
    get '/' do
      "ok"
    end

    post '/setup' do
      Repository.setup(params)
    end

    post '/ship' do
      Job.start(params)
    end
  end
end
