# Deployalot
Deployalot is a Node application for deploying web apps. It listens on port
8787 by default and watches for post requests to `/deploy`, which accepts the
following parameters:

```coffeescript
{
    # The github repo to deploy.
    "repo": "test",
    # The server environment to deploy to (e.g. production/staging)
    "server": "staging",
    # A command to run. Defaults to:
    # `bundle install --path vendor/gems --binstubs; rake deploy:<server>`
    "command": "echo 'hello world'"
}
```

## Hubot Integration
**TODO**
