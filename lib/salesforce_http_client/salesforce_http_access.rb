module SalesforceHttpClient
  module SalesforceHttpAccess
    attr_accessor :http_client

    def download_from_salesforce(output_save_path, report_id)
      create_http_client
      salesforce_login
      download_and_save_report(report_id, output_save_path)
      salesforce_logout
    end

    def create_http_client
      @http_client = HTTPClient.new
      @http_client.receive_timeout = @config.http_timeout
      @http_client.set_cookie_store(@config.cookie_store_file_path)
      @http_client
    end

    def salesforce_login
      @logger.info "try salesforce login..."
      @http_client.get config.salesforce_login_url
      body = { 'un' => @config.salesforce_login_id, 'pw' => @config.salesforce_password }
      response = @http_client.post(config.salesforce_login_url, body)
      respond_to_redirect(response)
    end

    def respond_to_redirect(response)
      while response.status == 302 && response.headers['Location'] && !response.headers['Location'].empty?
        @logger.info "redirect to #{response.headers['Location']}"
        response = @http_client.get(response.headers['Location'])
      end
    end

    def download_and_save_report(report_id, output_save_path)
      @logger.info "begin download reports"
      response = @http_client.get report_url(report_id)
      if response.status == 200
        report_content = response.content
        report_file = output_save_path
        @logger.info "save result to file #{report_file}"
        File.write(report_file, report_content)
      else
        @logger.error "failed to download reports."
      end
    end

    def salesforce_logout
      @logger.info "try salesforce logout..."
      @http_client.get config.salesforce_logout_url
      @logger.info "salesforce logged out."
    end
  end
end
