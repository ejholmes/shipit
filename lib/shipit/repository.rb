module Shipit
  class Repository < ActiveRecord::Base
    has_many :jobs

    def self.setup(params)
      uri  = "git@github.com:#{params[:repo]}"
      name = params[:name]
      new(:uri => uri, :name => name).tap { |r| r.save }
    end

    # TODO: Make configurable
    def command
      "bundle install --path vendor/gems --binstubs; bundle exec rake {{env}} deploy"
    end
  end
end
