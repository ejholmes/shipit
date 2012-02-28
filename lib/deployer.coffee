mkdirp = require('mkdirp').sync
exec = require('child_process').exec

Deployer =

  deploy: (path, env, opts = {}, cb) ->
    [path, user, repo] = path.match /(.*)\/(.*)/
    command = opts.command || "bundle install --path vendor/gems --binstubs; bundle exec rake deploy:#{env}"
    ref = "origin/#{opts.branch}" if opts.branch?
    ref = "#{opts.ref}" if opts.ref?
    ref or= "origin/master"

    base = process.env.DEPLOYALOT_BASE_DIR || "deploy"
    dir = "#{base}/#{user}/#{repo}"

    mkdirp(dir)
    process.chdir(dir)

    exec """
    if [ ! -d './.git' ]; then
      git init
      git remote add origin git@github.com:#{path}
    fi
    git fetch -q origin
    git reset -q --hard #{ref}
    """, (error, stdout, stderr) ->
      cb(error, stdout, stderr) if error
      exec command, cb

module.exports = Deployer
