source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'


gem 'jquery-rails'                          # Use jquery as the JavaScript library
gem 'haml-rails'
gem 'bootstrap-sass'                        # See https://github.com/thomas-mcdonald/bootstrap-sass#readme
gem 'font-awesome-rails'
gem 'formtastic'                            # see https://github.com/justinfrench/formtastic
gem 'will_paginate'                         # see https://github.com/mislav/will_paginate


# Background jobs for emails
gem "resque"                                # see https://github.com/resque/resque and http://railscasts.com/episodes/271-resque
gem "resque_mailer"                         # see https://github.com/zapnap/resque_mailer
#gem "github_api"

gem "omniauth-github"

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]


group :assets do
  # Use SCSS for stylesheets
  gem 'sass-rails', '~> 4.0.0'

  # Use CoffeeScript for .js.coffee assets and views
  gem 'coffee-rails', '~> 4.0.0'

  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'
end


group :development do
  gem 'pry-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'rack-mini-profiler'
  gem 'foreman'                       # see https://github.com/ddollar/foreman and http://railscasts.com/episodes/281-foreman
end


group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'pry-debugger'
  gem 'dotenv-rails'
  gem 'guard-rspec'                     # See https://github.com/guard/guard-rspec
  gem 'guard-livereload'
  gem 'guard-bundler'
  gem 'guard-zeus'                      # See https://github.com/qnm/guard-zeus
  gem 'capybara'
  gem 'selenium-webdriver'              # See https://github.com/nathandrewsire/selenium-webdriver-gem
  gem 'database_cleaner'
end


group :test do 
  gem 'resque_spec'                     # See https://github.com/leshill/resque_spec
end


group :production do
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
  gem 'therubyracer', :platform => :ruby, :require => 'v8'
  gem 'god'
end



