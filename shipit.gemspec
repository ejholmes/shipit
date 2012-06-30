# -*- encoding: utf-8 -*-
require File.expand_path('../lib/shipit/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Eric J. Holmes"]
  gem.email         = ["eric@ejholmes.net"]
  gem.description   = %q{Shipit is a sinatra app for continous deployment}
  gem.summary       = %q{Shipit is a sinatra app for continous deployment}
  gem.homepage      = "https://github.com/ejholmes/shipit"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "shipit"
  gem.require_paths = ["lib"]
  gem.version       = Shipit::VERSION

  gem.add_dependency "rake", "~> 0.9.2"
  gem.add_dependency "sinatra", "~> 1.3.2"
  gem.add_dependency "thin", "~> 1.3.1"
  gem.add_dependency "activerecord", "~> 3.2.6"

  gem.add_development_dependency "shotgun", "~> 0.9"
  gem.add_development_dependency "rspec", "~> 2.10.1"
end
