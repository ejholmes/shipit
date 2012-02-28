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
  """, (error, stdout, stderr) ->
    cb(error, stdout, stderr)

describe "Deployer", ->

  it "resets the working directory", ->
    jasmine.asyncSpecWait()
    cwd = process.cwd()
    Deployer.deploy 'ejholmes/test', 'staging', { command: 'ls' }, (error, stdout, stderr) ->
      console.log error
      expect(error).toEqual(null)
      expect(process.cwd()).toEqual(cwd)
      jasmine.asyncSpecDone()

  # it "creates the directory structure", ->
    # jasmine.asyncSpecWait()
    # Deployer.deploy 'ejholmes/test', 'staging', { command: 'ls' }, (error, stdout, stderr) ->
      # expect(error).toEqual(null)
      # expect(fs.statSync('deploy/ejholmes/test')).toBeTruthy()
      # jasmine.asyncSpecDone()
