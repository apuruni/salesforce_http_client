require 'logger'
require 'singleton'

module SalesforceHttpClient
  def self.configure(&block)
    SalesforceHttpClient::Configuration.configure(&block)
  end

  class Configuration
    include Singleton

    attr_accessor :salesforce_login_url
    attr_accessor :salesforce_logout_url

    attr_accessor :salesforce_login_id
    attr_accessor :salesforce_password

    attr_accessor :salesforce_instance_domain
    attr_accessor :salesforce_report_url_format
    attr_accessor :salesforce_report_id_param

    attr_accessor :http_timeout
    attr_accessor :tmp_dir

    attr_accessor :logger
    attr_accessor :log_level

    def self.configure
      yield instance
    end

    def initialize
      @salesforce_instance_domain = "https://ap.salesforce.com"

      @salesforce_login_url = "https://login.salesforce.com/"
      @salesforce_logout_url = ->() { @salesforce_instance_domain + "/secur/logout.jsp" }

      @salesforce_report_url_format = ->() { @salesforce_instance_domain + '/#{report_id}?export=1&enc=UTF-8&xf=csv' }
      @salesforce_report_id_param = '#{report_id}'

      @http_timeout = 5 * 60 * 1000
      @tmp_dir = './tmp'

      init_logger
    end

    def report_url(report_id)
      if @salesforce_report_url_format.is_a? Proc
        url_format = @salesforce_report_url_format.call
      else
        url_format = salesforce_report_url_format
      end

      url_format.gsub(@salesforce_report_id_param, report_id)
    end

    def logout_url
      if @salesforce_logout_url.is_a? Proc
        @salesforce_logout_url.call
      else
        @salesforce_logout_url
      end
    end

    def cookie_store_file_path
      File.join(@tmp_dir, 'cookie_store.dat')
    end

    private

    def init_logger
      if defined? Rails
        @logger = Rails.logger
      else
        @logger = Logger.new(STDOUT)
        @logger.level = Logger::WARN
      end
    end
  end
end
