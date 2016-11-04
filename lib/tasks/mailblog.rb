#!/usr/bin/env ruby
require 'dotenv'
Dotenv.load
require 'rubygems'
require 'bundler/setup'
require 'mailman'

# require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')

Mailman.config.logger = Logger.new('log/mailman.log')
Mailman.config.poll_interval = 60

Mailman.config.pop3 = {
  server: ENV['MAIL_SERVER'],
  port: ENV['MAIL_PORT'],
  ssl: ENV['MAIL_SSL'],
  username: ENV['MAIL_USERNAME'],
  password: ENV['MAIL_PASSWORD']
}

Mailman::Application.run do
  default do
    BlogMailer.receive(message)
  end
end
