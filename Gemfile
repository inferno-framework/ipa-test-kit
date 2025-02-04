# frozen_string_literal: true

source "https://rubygems.org"

gemspec

# Uncomment for local testing:
# gem 'inferno_core', path: '../inferno-core'
# Remove before merge; merge blocked by inferno_core 0.6.2 release:
gem 'inferno_core', git: 'git@gitlab.mitre.org:inferno/inferno-core.git', branch: 'main'


group :development, :test do
  gem 'debug'
  gem 'pry-byebug'
  gem 'rack-test'
end
