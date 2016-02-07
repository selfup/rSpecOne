class RspecInstall
  def initialize
    @init = init
  end

  def rspec_gemfile
"
source 'https://rubygems.org'

gem 'rails', '4.2.5.1'
gem 'pg', '~> 0.15'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

group :development, :test do
  gem 'pry'
  gem 'rails-pry'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'database_cleaner'
end

group :development do
  gem 'web-console', '~> 2.0'
end
"
  end

  def spec_helper
"
require 'capybara'
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
"
  end

  def rails_helper
"ENV['RAILS_ENV'] ||= 'test'\n" +

"require File.expand_path('../../config/environment', __FILE__)\n" +

"abort('The Rails environment is running in production mode!') if Rails.env.production?" +
"\n" +
"require 'spec_helper'\n" +

"require 'rspec/rails'\n" +

'ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.include FactoryGirl::Syntax::Methods
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end'
  end

  def init
    `rm -rf Gemfile`
    `echo "#{rspec_gemfile}" >> Gemfile`
    `bundle`
    puts "bundled"
    if `ls`.include?('spec')
      puts "rspec already installed!"
    else
      `rails generate rspec:install`
      puts "rspec generated"
    end
    `rm -rf test/`
    `mkdir spec/features`
    puts "made features and removed test dir"
    `rm -rf spec/spec_helper.rb`
    `rm -rf spec/rails_helper.rb`
    `echo "#{spec_helper}" >> spec/spec_helper.rb`
    `echo "#{rails_helper}" >> spec/rails_helper.rb`
    puts "capybara and DBcleaner are now implemented!"
  end
end

RspecInstall.new
