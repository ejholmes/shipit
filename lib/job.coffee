class Job
  @constructor: (@attrs) ->

  @find: (id) ->
    # Find the job in redis

  run: (callback) ->
    # Run the job
    callback()

  save: ->
    # Persist attrs in redis

module.exports = Job
