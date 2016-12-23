source 'https://rubygems.org'
puppetversion = ENV.key?('PUPPET_VERSION') ? "= #{ENV['PUPPET_VERSION']}" : ['>= 2.7']

gem 'puppet', puppetversion

group :development, :test do
  gem 'puppet-blacksmith'
  gem 'puppet-lint'
  gem 'puppetlabs_spec_helper'
  gem 'rake',                    '>=0.9.2.2'
  gem 'rspec-puppet'
end

group :system_tests do
  gem 'beaker', '~>2.51', :require => false
  gem 'beaker-rspec',     :require => false
  gem 'serverspec',       :require => false
end

gem 'hiera-puppet', :require => false
