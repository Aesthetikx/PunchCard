ENV['RACK_ENV'] = 'test'

require 'database_cleaner'
require 'factory_girl'
require 'faker'
require 'rack/test'
require 'rspec'
require 'timecop'

require 'punch_card'
require 'factories/punch.rb'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.after do
    Timecop.return
  end
end
