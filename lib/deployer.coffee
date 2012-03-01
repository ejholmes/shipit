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

  command: (command, fn) ->
    exec command, (args...) ->
      process.chdir(root)
      fn.apply(null, args)

  # Do the deployment
  deploy: (path, env, opts = {}, fn) ->
    [path, user, repo] = path.match /(.*)\/(.*)/
    command = opts.command || "bundle install --path vendor/gems --binstubs; bundle exec rake deploy:#{env}"
    ref = "origin/#{opts.branch}" if opts.branch?
    ref = "#{opts.sha}" if opts.sha?
    ref or= "origin/master"

    dir = "#{base}/#{user}/#{repo}"
    mkdirp(dir)
    process.chdir(dir)

    @clone path, ref, (args...) ->
      fn.apply(null, args) if args[0]
      @command command, fn
