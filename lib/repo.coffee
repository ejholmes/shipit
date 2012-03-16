Model = require './model'

class Repo extends Model
  @collection = 'repos'

  # Persist to redis
  save: (callback) ->
    key = "#{@collection}:#{@attrs.name}"
    @db.hmset "#{@collection}:#{@attrs.name}", @attrs, (err) ->
      callback(arguments) if err
      @db.sadd @collection, key, (err) ->
        callback(arguments)

module.exports = Repo
