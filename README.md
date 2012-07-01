# Shipit

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'shipit'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shipit

## Usage

TODO: Write usage instructions here

## Hubot
How I want to deploy:

```
hubot setup github/repo for deployment
hubot deploy repo/master to production #=> Deploying repo/master to the production environment
hubot deploy repo/feature to staging #=> Deploying repo/feature to the staging environment
hubot what's on staging? #=> repo/feature is currently on the staging environment
hubot lock staging because I'm collecting stats #=> Ok, I've locked the staging environment
hubot why is staging locked? #=> The staging environment is locked because User is collecting stats
hubot unlock staging #=> Ok, I've unlocked the staging environment
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
