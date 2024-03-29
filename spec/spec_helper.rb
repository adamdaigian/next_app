# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# disabling autorun (as mentionned here: https://github.com/burke/zeus)
# also explained here: http://robots.thoughtbot.com/post/40193452558/improving-rails-boot-time-with-zeus
#require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
  
  config.include Capybara::DSL
  
  # http://mrcktz.github.io/blog/2012/03/31/testing-omniauth/
  # http://samuelmullen.com/2011/05/simple-integration-testing-with-cucumber-and-omniauth/
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:github, {
    'info' => {'name' => 'Max Mustermann', 'image' => '', 'email' => 'iam@github.user'},
    'extra' => {'first_name' => 'Max','last_name' => 'Mustermann', 'raw_info'=>{'birthday'=>'08/01/1985','gender'=>'male'} },
    'uid' => '12345',
    'provider' => 'github',
    'credentials' => {'token' => 'token'}

  })

end
