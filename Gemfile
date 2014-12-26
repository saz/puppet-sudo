source 'https://rubygems.org'
puppetversion = ENV.key?('PUPPET_VERSION') ? "= #{ENV['PUPPET_VERSION']}" : ['>= 2.7']

gem 'puppet', puppetversion

group :development, :test do
  gem 'puppet-blacksmith'
  gem 'puppet-lint'
  gem 'puppetlabs_spec_helper'
  gem 'rake',                    '>=0.9.2.2'
  gem 'rspec-puppet', :github => 'rodjek/rspec-puppet'
end

gem 'hiera-puppet', :require => false
