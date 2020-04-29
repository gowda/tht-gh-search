# frozen_string_literal: true

source 'https://rubygems.org'

rails_version = '~> 6.0.0'
gem 'actionpack', rails_version
gem 'actionview', rails_version
gem 'activemodel', rails_version
gem 'activerecord', rails_version
gem 'activesupport', rails_version
gem 'railties', rails_version
gem 'sprockets-rails', '>= 2.0.0'

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'

gem 'bootstrap', '~> 4.4.1'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 4.0.0'
  gem 'rubocop', require: false
end

group :test do
  gem 'capybara'
  gem 'rails-controller-testing'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
end
