#!/usr/bin/env rake

require 'bundler'
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new(:spec) do |t|
  t.verbose = false
end

task :test => :spec
task :default => :spec
