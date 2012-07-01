module Shipit
  class Job < ActiveRecord::Base
    belongs_to :repository

    def self.start(params)
      repo = Repository.find_by_name(params[:name])
      env = params[:env] || "production"
      new(:repository => repo, :env => env).tap { |job| job.save }.run
    end
    
    # Runs the deploy
    def run
      self.clone
      self.deploy
    end

    def clone
      Kernel.system <<-SHELL
      mkdir -p #{dir}
      cd #{dir}
      if [ ! -d './.git' ]; then
        git init
        git remote add origin #{repository.uri}
      fi
      git fetch -q origin
      git reset -q --hard origin/master
      SHELL
    end

    def deploy
      self.output = ""
      command = "cd #{dir}; #{repository.command}"
      Bundler.with_clean_env do
        IO.popen(command, :err => [:child, :out]) do |io|
          io.each { |line| self.output << line }
        end
      end
      self.save
    end

    # Mocks cloning and deploying
    def self.enable_mock!
      self.class_eval do
        def clone
          Kernel.system <<-SHELL
          rm -rf #{dir}
          mkdir -p #{File.dirname(dir)}
          cp -r #{File.expand_path('../../../spec/fixtures/repo', __FILE__)} #{dir}
          SHELL
        end
      end
    end

  private

    def dir
      File.join(File.expand_path(tmpdir), repository.name)
    end

    def tmpdir
      "tmp/repos"
    end
    
  end
end
