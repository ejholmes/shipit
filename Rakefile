#!/usr/bin/env rake
$LOAD_PATH.unshift(File.expand_path("../lib", __FILE__))
ENV["RACK_ENV"] ||= "development"
require "bundler/gem_tasks"

require "shipit"
Shipit.setup(ENV)
require "shipit/tasks"

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
