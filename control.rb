#!/usr/bin/env ruby
require 'rubygems'
require 'bundler'

Bundler.require # bring in all the gems

# Require our own libraries.and credentials
require File.join(Dir.pwd, 'config', 'creds.rb')
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |f| require f }

binding.pry
