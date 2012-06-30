module Shipit
  class Job
    def self.start(params)
      repo = Repository.find_by_name(params[:name])
      env = params[:env] || "production"
      new(repo, env).run
    end

    def initialize(repo, env)
      @repo = repo
      @env  = env
    end
    
    # Runs the deploy
    def run
      self.clone
      self.deploy
    end

    def clone
      system <<-SHELL
      mkdir -p #{dir}
      cd #{dir}
      if [ ! -d './.git' ]; then
        git init
        git remote add origin #{@repo.uri}
      fi
      git fetch -q origin
      git reset -q --hard origin/master
      SHELL
    end

    def deploy
      
    end

  private

    def dir
      File.join(File.expand_path(tmpdir), @repo.name)
    end

    def tmpdir
      "tmp/repos"
    end
    
  end
end
