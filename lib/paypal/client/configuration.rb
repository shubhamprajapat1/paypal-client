module Paypal
module Client
  class Configuration
    attr_accessor :client_id, :client_secret, :return_url, :login_url, :api_base_url

    def initialize
      @client_id     = nil
      @client_secret = nil
      @return_url    = nil
      @api_base_url  = 'https://api-m.sandbox.paypal.com'
      @login_url     = 'https://sandbox.paypal.com'
    end
  end
end
end