require 'mini-smtp-server'
# This is an SMTP server that logs all
# the messages it receives to STDOUT
class StdoutSmtpServer < MiniSmtpServer

  def new_message_event(message_hash)
    puts "# New email received:"
    puts "-- From: #{message_hash[:from]}"
    puts "-- To:   #{message_hash[:to]}"
    puts "--"
    puts "-- " + message_hash[:data].gsub(/\r\n/, "\r\n-- ")
    puts
	
  end

end

server = StdoutSmtpServer.new(2525, '0.0.0.0', 5)
server.start
server.join
