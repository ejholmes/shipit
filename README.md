# Deployalot
Deployalot is a Node application for deploying web apps.

## Setup
Post to `/setup`.

**Example payload**

```coffeescript
{
    # The github repo to deploy.
    "repo": "github/test",
    
    # (Optional) A unique name for this project. Defaults to the github repo name
    "name": "test",

    # (Optional) A command to run. Defaults to:
    # `bundle install --path vendor/gems --binstubs; bundle exec rake deploy:{{env}}`
    # {{env}} gets replaced with the value of the "env" key during deploy.
    "command": "echo '{{env}}'",
    
    # (Optional) Send post data with stdout, stderr and status code to the url specified when a deployment
    # completes. Multiple servers can be specified by seperating them with spaces
    "notify": "http://hubot.me.com:8989/ http://something:5555/"
}
```

**Returns**

```coffeescript
{
    "name": "test"
}
```

## Deploy
Get to `/deploy/:name/to/:env`.

**Example**

```bash
$ curl http://localhost:8787/deploy/test/to/staging
```

If the command completes successfully, HTTP status code 200 is returned with the job id.

```coffeescript
{
    "name": "test",
    "job": "someid"
}
```

Once the job completes, the "notify" servers specified during setup will be notified.

## Hubot Integration
**TODO**
