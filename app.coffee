Util = require 'util'
Http = require 'http'

deploy = require('./lib/deployer').deploy

port = process.env.DEPLOYALOT_PORT || 8787

server = Http.createServer (req, res) ->
  if req.method is 'POST'
    deploy 'ejholmes/libopenfocus', 'staging', {}, (error, stdout, stderr) ->
      status = if error then 500 else 200
      res.writeHead status, "Content-Type": "application/json"
      res.write JSON.stringify
        stdout: stdout
        stderr: stderr
      res.end()
  else
    res.writeHead 200, "Content-Type": "text/html"
    res.write "OK"
    res.end()

server.listen(port)
console.log "Server started on port #{port}"
