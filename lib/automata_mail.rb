# this server submits all incoming 
# mails with HTTP content, to an Automata Server
require 'rest_client'
require './lib/helpers/job_builder'

class AutomataMail < MiniSmtpServer

  def new_message_event(message_hash)
    puts "# New email received:"
    puts "-- From: #{message_hash[:from]}"
    puts "-- To:   #{message_hash[:to]}"
    puts "--"
    puts "-- " + message_hash[:data].gsub(/\r\n/, "\r\n-- ")
    puts
     puts "Sending mail..."
     begin
      jdata = Automata::JobBuilder.build_mail(message_hash)
      submit_data(jdata)
     rescue Exception => e
        puts e.to_s
        puts e.backtrace.join("\n")
     end
  end

  def submit_data(data)
      begin
         puts "Connecting to #{automata_url} to submit:\n#{data}"
         RestClient.put automata_url(), data, {:content_type => :json}
      rescue Exception => e
        puts "Connection failed to #{automata_url}. Server unavailable: #{e.to_s}\n#{e.backtrace.join("\n")}"
      end
  end

  def automata_url
      puts "#{ENV["AUTOMATA_SERVER"]}#{ENV["AUTOMATA_TUBE"]}/"
      return "#{ENV["AUTOMATA_SERVER"]}#{ENV["AUTOMATA_TUBE"]}"
  end

end

server = AutomataMail.new(2525, '0.0.0.0', 5)
server.start
server.join
