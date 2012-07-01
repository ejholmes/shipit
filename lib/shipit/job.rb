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
      Kernel.system <<-SHELL
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
      Bundler.with_clean_env do
        Kernel.system <<-SHELL
        cd #{dir}
        bundle install
        SHELL
      end
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
      File.join(File.expand_path(tmpdir), @repo.name)
    end

    def tmpdir
      "tmp/repos"
    end
    
  end
end
