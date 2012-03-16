Model = require './model'

class Job extends Model
  run: (callback) ->
    # Run the job
    callback()

module.exports = Job
