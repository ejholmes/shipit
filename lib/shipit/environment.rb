module Shipit
  class Environment < ActiveRecord::Base
    belongs_to :repository

    def self.find_or_create(repo, name)
      env = self.find_by_name(name) || begin
        self.new(:repository => repo, :name => name).tap { |r| r.save }
      end
    end

    def command
      self.repository.command.gsub /{{env}}/, self.name
    end
  end
end
