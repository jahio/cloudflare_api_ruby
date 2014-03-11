#!/usr/bin/env ruby
require 'rubygems'
require 'bundler'

Bundler.require # bring in all the gems

# Require our own libraries.and credentials
require File.join(Dir.pwd, 'config', 'creds.rb')
require File.join(Dir.pwd, 'lib', 'api_wrapper.rb')

binding.pry
