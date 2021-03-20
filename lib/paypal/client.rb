require "paypal/client/version"
require "paypal/client/configuration"
require "paypal/client/http_request"

module Paypal
  module Client
    class Error < StandardError; end
    # Your code goes here...
    class << self
      attr_accessor :configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.reset
      @configuration = Configuration.new
    end

    def self.configure
      yield(configuration)
    end

    def self.get_access_token(token, grant_type = 'authorization_code')
      end_point = '/v1/identity/openidconnect/tokenservice'
      body      = 'grant_type='
      body      += grant_type == 'authorization_code' ? 'authorization_code&code=' : 'refresh_token&refresh_token='
      body      += "#{token}"
      HttpRequest.new.call(end_point, body, 'Basic')
    end

    def self.authorization_url(scope = 'openid profile email address')
      encode_return_url = URI.encode_www_form_component(Paypal::Client.configuration.return_url)
      client_id         = Paypal::Client.configuration.client_id
      login_url         = Paypal::Client.configuration.login_url
      "#{login_url}/connect/?flowEntry=static&client_id=#{client_id}&response_type=code&scope=#{scope}&redirect_uri=#{encode_return_url}"
    end

    def self.get_userinfo(access_token)
      end_point = '/v1/identity/oauth2/userinfo?schema=paypalv1.1'
      HttpRequest.new(access_token).get_call(end_point)
    end


    def self.get_transaction(start_date, end_date, access_token)
      end_point = "/v1/reporting/transactions?start_date=#{start_date}&end_date=#{end_date}&fields=all"
      HttpRequest.new(access_token).get_call(end_point)
    end
  end
end


