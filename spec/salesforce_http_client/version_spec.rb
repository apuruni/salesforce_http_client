require 'spec_helper'
require 'salesforce_http_client/version'

module SalesforceHttpClient
  describe 'VERSION' do
    it 'has a version number' do
      expect(SalesforceHttpClient::VERSION).not_to be nil
    end
  end
end
