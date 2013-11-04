#!/usr/bin/env ruby
require 'bundler/setup'
Bundler.require
Dotenv.load

require './lib/automata_mail'
server = AutomataMail.new(2525, '0.0.0.0', 5)
server.start
server.join
