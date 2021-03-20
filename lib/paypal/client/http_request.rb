module Paypal
module Client
class HttpRequest
  def initialize(access_token = '')
    @access_token = access_token
  end

  def authorization_header( type = 'Bearer' )
    type == 'Bearer' ? "Bearer #{@access_token}" : "Basic " + client_id_base64
  end

  def client_id_base64
    client_id     = Paypal::Client.configuration.client_id
    client_secret = Paypal::Client.configuration.client_secret
    Base64::encode64("#{client_id}:#{client_secret}").delete!("\n")
  end

  def call(end_point, body, type = 'Bearer')
    begin
      url = URI("#{api_base_url}#{end_point}")
      https         = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request       = Net::HTTP::Post.new(url)
      request.body  = body
      request["Authorization"] = authorization_header(type)
      request["Content-Type"]  = "application/x-www-form-urlencoded"
      res = https.request(request)
      res = JSON.parse(res.read_body)
    rescue Exception => e
      res = { "error_description"=>"#{e.message}", "error"=>"System Error" } 
    end
    res
  end

  def get_call(end_point, type = 'Bearer')
    begin
      url = URI("#{api_base_url}#{end_point}")
      https         = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request       = Net::HTTP::Get.new(url)
      request["Authorization"] = authorization_header(type)
      request["Content-Type"]  = "application/x-www-form-urlencoded"
      res = https.request(request)
      res = JSON.parse(res.read_body)
    rescue Exception => e
      res = { "error_description"=>"#{e.message}", "error"=>"System Error" } 
    end
    res
  end

  def api_base_url
    api_base_url = Paypal::Client.configuration.api_base_url
  end
end
end
end