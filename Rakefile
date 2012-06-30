#!/usr/bin/env rake
$LOAD_PATH.unshift(File.expand_path("../lib", __FILE__))
ENV["RACK_ENV"] ||= "development"
require "bundler/gem_tasks"

require "shipit"
Shipit.setup(ENV)
require "shipit/tasks"
