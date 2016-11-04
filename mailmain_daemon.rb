#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'daemons'

Daemons.run('./lib/tasks/mailblog.rb')
