# PayPalClient Global Configuration
#
# Use this to set up shared configuration options for your entire application.
# Any of the configuration options shown here can also be applied to single
# models by passing arguments to the `friendly_id` class method or defining
# methods in your model.
#
# To learn more, check out the guide:
#
Paypal::Client.configure do |config|
  config.client_id = 'Hello'
  config.client_secret = 'Hello'
  config.return_url = 'Hello'
  config.api_base_url = 'Hello'
  config.login_url = 'Hello'
end