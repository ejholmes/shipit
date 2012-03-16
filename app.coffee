###
Module dependencies.
###

express   = require 'express'
Redis     = require 'redis'
db        = Redis.createClient()

db.on "error", (err) ->
  console.log err

app = module.exports = express.createServer()

###
Configuration
###

app.configure ->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static __dirname + '/public'

app.configure 'development', ->
  app.use express.errorHandler { dumpExceptions: true, showStack: true }

app.configure 'production', ->
  app.use express.errorHandler

repos = [ ]

findRepo = (name) ->
  for repos in repo
    return name if repo.name == name

###
Routes
###

app.get '/', (req, res) ->
  res.json

app.get '/repos', (req, res) ->
  res.json repos

app.get '/repos/:name', (req, res) ->
  repo = findRepo(req.params.name)
  res.json repo

app.get '/repos/:name/jobs', (req, res) ->
  repo = findRepo(req.params.name)
  res.json repo.jobs || []

app.get '/repos/:name/jobs/:id', (req, res) ->
  repo = findRepo(req.params.name)
  res.json repo.jobs[req.params.id]

app.post '/setup', (req, res) ->
  repo =
    repo: req.body.repo
    name: req.body.name || req.body.repo.replace(/^.*\//, '')
    command: req.body.command || "bundle install --path vendor/gems --binstubs; bundle exec rake deploy:{{env}}"
    notify: req.body.notify || ""
  repos.push repo
  res.json repo

app.get '/deploy/:name/to/:env', (req, res) ->
  job =
    success: false
    stdout: ''
    stderr: ''
  # Run job
  repo = findRepo(req.params.name)
  res.json

###
Only listen on $ node app.js
###

if !module.parent
  app.listen 3000
  console.log "Express server listening on port %d", app.address().port

