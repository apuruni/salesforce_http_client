require 'spec_helper'

module SalesforceHttpClient
  describe Client do
    describe 'basic' do
      it 'can be init' do
        client = SalesforceHttpClient::Client.new
        expect(client).to_not be_nil
      end
    end

    describe '#download_report' do
      before do
        stub_request(:get, "https://login.salesforce.com/")
          .to_return(status: 200, body: "", headers: {})

        stub_request(:post, "https://login.salesforce.com/")
          .with(body: { "pw" => "test_password", "un" => "test_login_id" })
          .to_return(status: 302, body: "", headers: { 'Location' => 'https://ap.salesforce.com/secur/frontdoor.jsp?sid=00D10000000ZIju%21ARkAQBU5ixFxxAzNvQTreC6rOQ9QSt_cMxFbwmVoVNbWtl.xxHasjFO8v100wa6b0kv.c9Q9RzYuwss9F5TodikF.ELZAHwq&apv=1&cshc=0000001shFs0000000ZIju&display=page' })

        stub_request(:get, "https://ap.salesforce.com/secur/frontdoor.jsp?apv=1&cshc=0000001shFs0000000ZIju&display=page&sid=00D10000000ZIju!ARkAQBU5ixFxxAzNvQTreC6rOQ9QSt_cMxFbwmVoVNbWtl.xxHasjFO8v100wa6b0kv.c9Q9RzYuwss9F5TodikF.ELZAHwq")
          .to_return(status: 200, body: "", headers: {})

        stub_request(:get, "https://ap.salesforce.com/a?enc=UTF-8&export=1&xf=csv")
          .to_return(status: 200, body: "", headers: {})

        stub_request(:get, "https://ap.salesforce.com/secur/logout.jsp")
          .to_return(status: 200, body: "", headers: {})
      end

      it 'can download report' do
        Configuration.configure do |config|
          config.salesforce_login_id = 'test_login_id'
          config.salesforce_password = 'test_password'
        end

        output_file = "tmp/report_a.csv"
        File.delete(output_file) if File.exist?(output_file)

        client = SalesforceHttpClient::Client.new
        client.download_report("a", output_file)
      end
    end
  end
end
