source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.6'

# CORE
gem 'rake', '~> 13.0.1'
gem 'rails', '~> 5.2.1', '>= 5.2.1.1'
gem 'bootsnap', '~> 1.4', require: false # Reduces boot times through caching; required in config/boot.rb
gem 'puma', '~> 4.3' # Use Puma as the app server
# gem 'puma', '~> 3.11' # Use Puma as the app server

# RUBY HACKING
gem 'concurrent-ruby', '~> 1.1'
gem 'virtus', '~> 1.0'
gem 'tzinfo-data', '~> 1.2019' # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'active_hash', '~> 2.3'

# DATA
gem 'pg', '~> 1.1'
gem 'kaminari', '~> 1.2' 
gem 'paranoia', '~> 2.4'
gem 'ice_nine', '~> 0.11'
gem 'textacular', '~> 5.0'
gem 'activerecord-import'

# JOB SERVER
gem 'redis', '~> 4.1'
gem 'hiredis', '~> 0.6'
gem 'redis-rails', '~> 5.0'

# MIDDLEWARE
gem 'rack-timeout', '~> 0.5'    # abort requests that are taking too long
gem 'rack-cors', '~> 1.0'       # handles Cross-Origin Resource Sharing

# JSON, API SEC
gem 'oj', '~> 3.9'
gem 'jbuilder', '~> 2.9'
gem 'jsonapi-rails', '~> 0.4'
gem 'jwt', '~> 2.2'
gem 'nokogiri', '~> 1.10'

# EXTERNAL SERVICES
gem 'searchkick'

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# DEBUG/PRY
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

# TESTING
group :test, :development do
  gem 'dotenv-rails', '~> 2.7'
  gem 'bullet'
  gem 'rspec-rails'
  gem 'rubocop', '~> 0.58', require: false
end

# GUARD / AUTO TEST
group :test, :development do
  gem 'factory_bot_rails'
  gem 'faker', require: false
end

# TEST
group :test do
  gem 'database_cleaner'
  gem 'mock_redis'
  gem 'shoulda-matchers'
end
