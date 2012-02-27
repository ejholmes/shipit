# Deployalot
Deployalot is a Node application for deploying web apps. It listens on port
8787 by default and watches for post requests to `/deploy`, which accepts the
following parameters:

* **repo**: The github repo to deploy.
* **server**: The server environment to deploy to (e.g. production/staging).
* **command**: A command to run. Defaults to `rake deploy:<server>`.

## Hubot Integration
**TODO**
