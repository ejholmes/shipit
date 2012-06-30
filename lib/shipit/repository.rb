module Shipit
  class Repository < ActiveRecord::Base
    def self.setup(params)
      uri  = "git@github.com:#{params[:repo]}"
      name = params[:name]
      new(:uri => uri, :name => name).tap { |r| r.save }
    end
  end
end
