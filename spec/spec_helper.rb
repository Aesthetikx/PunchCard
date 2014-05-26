require 'rspec'
require 'factory_girl'
require 'timecop'

require 'punch_card'
require 'factories/punch.rb'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.after do
    Timecop.return
  end
end
