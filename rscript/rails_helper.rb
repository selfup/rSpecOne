class RailsHelper
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
end
