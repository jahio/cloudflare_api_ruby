#
# creds.rb
#
# Put your Cloudflare credentials in this particular file. They'll be used
# by control.rb to perform API requests to Cloudflare.
# When you're done, RENAME this file to simply "creds.rb":
#
# mv config/creds_example.rb config/creds.rb

ENV['cloudflare_api_key'] = 'YOUR API KEY HERE'
ENV['cloudflare_email']   = 'YOUR CLOUDFLARE EMAIL HERE'
