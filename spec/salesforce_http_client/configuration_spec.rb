require 'spec_helper'

module SalesforceHttpClient
  describe '.configure' do
    it 'can set config value.' do
      SalesforceHttpClient.configure do |config|
        config.salesforce_login_id = 'login_id'
        config.salesforce_password = 'password'
      end

      config = Configuration.instance

      expect(config.salesforce_login_id).to eq 'login_id'
      expect(config.salesforce_password).to eq 'password'
    end
  end

  describe Configuration do
    it 'can be init' do
      client = Configuration.instance
      expect(client).to_not be_nil
    end

    describe '.configure' do
      it 'can set config value.' do
        Configuration.configure do |config|
          config.salesforce_login_id = 'login_id'
          config.salesforce_password = 'password'
        end

        config = Configuration.instance

        expect(config.salesforce_login_id).to eq 'login_id'
        expect(config.salesforce_password).to eq 'password'
      end
    end
  end
end
