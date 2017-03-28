
require 'telegram/bot'

require 'net/http'
require "open-uri"



def login()
	uri = URI.parse("http://nn.en.cx/Login.aspx?return=%2fDefault.aspx")
	request = Net::HTTP::Post.new(uri)
	request.content_type = "application/x-www-form-urlencoded"
	request["Cookie"] = "GUID=2a689e8a%2D2534%2D4b37%2Da333%2Dcaa332e5f218; stoken=oq4hw0zwuhokv3yvjnmckgj4; __utmt_t0=1; lang=ru; __utma=177705850.2095619733.1488189083.1490168472.1490171551.7; __utmb=177705850.2.10.1490171551; __utmc=177705850; __utmz=177705850.1488189083.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); Domain=nn%2Een%2Ecx; stoken=oq4hw0zwuhokv3yvjnmckgj4; check=1"
	request["Origin"] = "http://nn.en.cx"
	request["Accept-Language"] = "en-GB,en-US;q=0.8,en;q=0.6"
	request["Upgrade-Insecure-Requests"] = "1"
	request["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36 OPR/43.0.2442.1165"
	request["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
	request["Cache-Control"] = "max-age=0"
	request["Referer"] = "http://nn.en.cx/Login.aspx?return=%2fDefault.aspx"
	request["Connection"] = "keep-alive"
	request.set_form_data(
	  "socialAssign" => "0",
	  "Login" => "Kostya_fire",
	  "Password" => "4173172wassupmanen",
	  "EnButton1" => "Вход",
	  "ddlNetwork" => "1",
	)

	req_options = {
	  use_ssl: uri.scheme == "https",
	}

	response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
	  http.request(request)
	end
	
	response
end

token = '362490256:AAH5fhLG442rSt-wwt-aBPXbFRe7kHSws6A'
url = 'https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap
&markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318
&markers=color:red%7Clabel:C%7C40.718217,-73.998284&key=AIzaSyCBqXSbkVL73hJ9j9EE9trg2x7aPgA8Sx8'
uri = URI.encode(url)

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.sendMessage(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
      bot.api.sendMessage(chat_id: message.chat.id, text: login)
		Net::HTTP.start("static.flickr.com") { |http|
  		resp = http.get(uri)
  		open("fun.jpg", "wb") { |file|
    		file.write(resp.body)
		   }
		}
    end
  end
end


