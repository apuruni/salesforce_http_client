$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'salesforce_http_client'

RSpec.configure do
  require 'webmock/rspec'
end