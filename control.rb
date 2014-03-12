#!/usr/bin/env ruby
require 'rubygems'
require 'bundler'

Bundler.require # bring in all the gems

# Require our own libraries.and credentials
require File.join(Dir.pwd, 'config', 'creds.rb')
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |f| require f }

# From here, you can do whatever you want with code. A few examples:
#
# Add a batch of basic subdomains that are CNAME entries to the same domain:
# z = Zone.new("example.com")
# ['foo', 'bar', 'bar.foo', 'foo.bar'].each do |x|
#   z.add_subdomain("CNAME", x)
# end
#
# Add a single A record to a zone with a 120sec TTL:
# z = Zone.new("example.com")
# z.add_subdomain("CNAME", "foo", "1.2.3.4", 120)
#
# Maybe you have a big array of domains and don't care if they already exist,
# you just want to make sure they've been added.
# z = Zone.new("example.com")
# ['big', 'array'].each do |x|
#   begin
#     z.add_subdomain("CNAME", x)
#   rescue DomainExistsError => e
#     # No op. Don't care that it exists, that's great. Maybe log that to stderr
#     STDERR.puts(e)
#   end
# end

binding.pry # drop the user into a console if they don't modify this file
