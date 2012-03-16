###
Module dependencies.
###

express   = require 'express'
Redis     = require('redis')
db    = Redis.createClient()

Job       = require('./lib/job')
Repo      = require('./lib/repo')

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

###
Routes
###

app.get '/', (req,res) ->
  res.render 'index', {title: 'Express'}

app.post '/setup', (req, res) ->
  repo = new Repo(req.params)
  res.json "done": true

app.get '/deploy/:name/to/:env', (req, res) ->
  repo = Repo.find(req.params.name)
  job = new Job()
  job.run ->
    console.log "ran job"
    res.json "job": "someId"

###
Only listen on $ node app.js
###

if !module.parent
  app.listen 3000
  console.log "Express server listening on port %d", app.address().port

