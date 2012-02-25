# Deployalot
Deployalot is a Sinatra application for deploying web apps. It listens on port
8787 by default and watches for post requests to `/deploy`, which accepts the
following parameters:

* **repo**: The github repo to deploy.
* **server**: The server environment to deploy to (e.g. production/staging).
* **task**: The rake task to run. Defaults to `deploy`. **server** will be passed
  as an environment variable to this task.

## Hubot Integration
**TODO**
