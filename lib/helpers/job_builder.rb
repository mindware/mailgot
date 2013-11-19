require 'json'
module Automata
	module JobBuilder

		def self.build_mail(m)
			begin
			# eventually we'll first task a validate_email with on_success
			# email_filter_urls, then we'll on_success new_task a put request.
			data = { # each root key is an action, in this case, email_filter_urls
				 "email_filter_urls" =>
					 { 
						"params" =>   
							{ 'from' => m[:from],
							  'to'   => m[:to], 
							  'data' => m[:data] },
						 "on_success" => {
							"put_data_to_url" => {
								'url' => $API_URL_PUT_URLS
							}
				 		}
					} 	
				}
			json = data.to_json
			puts "Building JSON: #{json}"
			return json
			rescue Exception => e
				error("Error ocurred when building JSON from mail: #{e.to_s}")
				return false
			end
		end

	end
end
