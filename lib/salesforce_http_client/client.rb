require 'salesforce_http_client/salesforce_http_access'

module SalesforceHttpClient
  class Client
    include SalesforceHttpAccess

    attr_accessor :config
    attr_accessor :logger

    def initialize
      @config = Configuration.instance
      @logger = config.logger
    end

    def download_report(report_id, output_save_path, override_if_exists = false)
      return if check_override_ng(output_save_path, override_if_exists)
      download_from_salesforce(output_save_path, report_id)
    end

    private

    def check_override_ng(output_save_path, override_if_exists)
      if !override_if_exists && File.exist?(output_save_path)
        @logger.error "file exists: #{output_save_path}"
        true
      else
        delete_exist_file(output_save_path)
        false
      end
    end

    def delete_exist_file(output_save_path)
      return unless File.exist?(output_save_path)
      File.delete(output_save_path)
      @logger.info "exist file deleted: #{output_save_path}"
    end

    def report_url(report_id)
      @config.report_url(report_id)
    end
  end
end
