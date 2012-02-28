# Deployalot
Deployalot is a Node application for deploying web apps. It listens on port
8787 by default and watches for post requests to `/deploy`, which accepts the
following parameters:

```coffeescript
{
    # The github repo to deploy.
    "repo": "github/test",

    # The server environment to deploy to (e.g. production/staging)
    "server": "staging",

    ###################
    # Optional Parameters
    ##################

    # A command to run. Defaults to:
    # `bundle install --path vendor/gems --binstubs; bundle exec rake deploy:<server>`
    "command": "echo 'hello world'"

    # A specific branch to deploy
    "branch": "develop",

    # A specific tag to deploy
    "tag": "0.2.1",

    # A specific SHA to deploy
    "sha": "839e6d2"
}
```

## Hubot Integration
**TODO**
