Redis = require 'redis'
db = Redis.createClient()

class Model
  @db         = db
  @collection = null

  @constructor: (@attrs) ->

  # Attempts to find by key
  @find: (key, callback) ->
    @db.hgetall "#{@collection}:#{key}", callback

  save: (callback) ->

module.exports = Model
