Deployer = require('../lib/deployer')
deploy = Deployer.deploy

describe "Deployer", ->

  it "deploys", ->
    deploy 'ejholmes/libopenfocus', 'staging', (error, stdout, stderr) ->
      console.log stdout, stderr

  it "deploys a branch", ->
    deploy 'ejholmes/libopenfocus', 'staging', branch: 'develop', (error, stdout, stderr) ->
      console.log stdout, stderr

  it "does something else", ->
    deploy 'ejholmes/libopenfocus', 'staging', ref: '839e6d2', (error, stdout, stderr) ->
      console.log stdout, stderr
