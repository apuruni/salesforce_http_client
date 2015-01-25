$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'salesforce_http_client'

require 'coveralls'
Coveralls.wear!

RSpec.configure do
  require 'webmock/rspec'
end
