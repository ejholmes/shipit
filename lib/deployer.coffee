mkdirp = require('mkdirp').sync
exec = require('child_process').exec

module.exports =

  # Clones the repository and passes the result to +cb+
  clone: (path, ref, cb) ->
    exec """
    if [ ! -d './.git' ]; then
      git init
      git remote add origin git@github.com:#{path}
    fi
    git fetch -q origin
    git reset -q --hard #{ref}
    """, (error, stdout, stderr) ->
      cb(error, stdout, stderr)

  # Do the deployment
  deploy: (path, env, opts = {}, cb) ->
    [path, user, repo] = path.match /(.*)\/(.*)/
    command = opts.command || "bundle install --path vendor/gems --binstubs; bundle exec rake deploy:#{env}"
    ref = "origin/#{opts.branch}" if opts.branch?
    ref = "#{opts.sha}" if opts.sha?
    ref or= "origin/master"

    base = process.env.DEPLOYALOT_BASE_DIR || "deploy"
    dir = "#{base}/#{user}/#{repo}"

    cwd = process.cwd()
    mkdirp(dir)
    process.chdir(dir)

    @clone path, ref, (error, stdout, stderr) ->
      cb(error, stdout, stderr) if error
      exec command, (error, stdout, stderr) ->
        process.chdir(cwd)
        cb(error, stdout, stderr)

