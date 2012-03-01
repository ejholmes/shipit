mkdirp = require('mkdirp').sync
exec = require('child_process').exec

# Root directory
root = process.cwd()
base = "#{root}/#{process.env.DEPLOYALOT_BASE_DIR || 'deploy'}"

module.exports =

  # Clones the repository and passes the result to +fn+
  clone: (path, ref, fn) ->
    exec """
    if [ ! -d './.git' ]; then
      git init
      git remote add origin git@github.com:#{path}
    fi
    git fetch -q origin
    git reset -q --hard #{ref}
    """, (args...) -> fn.apply(null, args)

  # Executes the deploy command
  command: (command, fn) ->
    exec command, (args...) ->
      process.chdir(root)
      fn.apply(null, args)

  # Do the deployment
  deploy: (opts = {}, fn) ->
    [path, user, repo] = opts.repo.match /(.*)\/(.*)/
    command = opts.command || "bundle install --path vendor/gems --binstubs; bundle exec rake deploy:#{opts.server}"
    ref = "origin/#{opts.branch}" if opts.branch?
    ref = "#{opts.sha}" if opts.sha?
    ref or= "origin/master"

    dir = "#{base}/#{user}/#{repo}"
    mkdirp(dir)
    process.chdir(dir)

    @clone path, ref, (args...) ->
      fn.apply(null, args) if args[0]
      @command command, fn
