require 'sinatra'

module Deployalot
  class Application < Sinatra::Base

    # params ->
    #   :repo
    #   :server
    #   :task [deploy:<server>]
    post '/deploy' do
    end

  end
end
