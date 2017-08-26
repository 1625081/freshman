# Load the Rails application.
require_relative 'application'

# begin
#   Tire.configure do
#     logger STDERR
#     url Settings.elasticsearch_url
#   end
# rescue => e
#   p "Wrong configuration: #{e}"
# end

# $client ||= WeixinAuthorize::Client.new(ENV["APPID"], ENV["APPSECRET"])
# $client.is_valid?
# Initialize the Rails application.
Rails.application.initialize!
