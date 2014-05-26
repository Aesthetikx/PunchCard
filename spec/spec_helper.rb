ENV['RACK_ENV'] = 'test'

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
  config.after do
    Timecop.return
  end
end
