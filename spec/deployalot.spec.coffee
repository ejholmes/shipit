Deployer = require('../lib/deployer')

fs = require 'fs'
exec = require('child_process').exec

Deployer.clone = (path, ref, cb) ->
  exec """
  if [ ! -d './.git' ]; then
    git init
    git remote add origin ../../../spec/fixtures/git
  fi
  git fetch -q origin
  git reset -q --hard #{ref}
  """, (args...) ->
    cb.apply(null, args)

describe "Deployer", ->

  it "resets the working directory", ->
    jasmine.asyncSpecWait()
    cwd = process.cwd()
    Deployer.deploy repo: 'ejholmes/test', server: 'staging', command: 'ls', (error, stdout, stderr) ->
      console.log error
      expect(error).toEqual(null)
      expect(process.cwd()).toEqual(cwd)
      jasmine.asyncSpecDone()
