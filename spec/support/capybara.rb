require 'capybara/rspec'
require 'capybara/rails'

# Compensate async Ajax calls
Capybara.automatic_reload = true

# Return port
Capybara.always_include_port = true

RSpec.configure do |config|
  config.include Capybara::DSL
end