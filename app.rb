require 'sinatra'
require 'openweathermap'

API_KEY = ENV["API_KEY"]
API = OpenWeatherMap::API.new(API_KEY, 'en', 'imperial')

class String
  def is_i?
     /\A[-+]?\d+\z/ === self
  end
end

PRE_HTML = %{<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Weatherman</title>
    <link rel="stylesheet" href="style.css">
    <script src="script.js"></script>
  </head>
  <body>
}

POST_HTML = %{
    <p>
      <form action="/">
        <label for="city">City:</label><br>
        <input type="text" id="city" name="city"><br>
        <label for="statee">State:</label><br>
        <input type="text" id="state" name="state"><br>
        <input type="submit" value="Submit">
      </form>
    </p>
  </body>
</html>
}

def get_weather(location) 
  conditions = API.current(location).weather_conditions
  {"time" => conditions.time, "description" => conditions.description, "temperature" => conditions.temperature, 
    "low" => "#{conditions.temp_min} F", "high" => "#{conditions.temp_max} F",
    "humidity" => conditions.humidity, "wind" => conditions.wind
  }
end


get '/' do
  content_type 'text/html'
  city = request["city"]
  state = request["state"]
  location = "#{city}, #{state}"
  location = "beverly hills, california" if city.nil? || city == ""
  if (city != "" && state != "") || (!city.nil? && !state.nil?)
    conditions = get_weather(location)
    weather_details = ""
    conditions.each {|k,v| weather_details.concat("<ul><li>#{k.capitalize}: #{v}</li></ul>")}
    PRE_HTML + "      <h1>Weather Lookup</h1>" + "<h3>#{location.split.map(&:capitalize).join(' ')}" + weather_details + POST_HTML
  else
    PRE_HTML + "      <h1>Weather Lookup</h1>" +  POST_HTML
  end

end





# THIS IS FOR DEBUGGING
# t = %w[text/css text/html application/javascript]
# puts request.accept              # ['text/html', '*/*']
# puts request.accept? 'text/xml'  # true
# puts request.preferred_type(t)   # 'text/html'
# puts request.body                # request body sent by the client (see below)
# puts request.scheme              # "http"
# puts request.script_name         # "/example"
# puts request.path_info           # "/foo"
# puts request.port                # 80
# puts request.request_method      # "GET"
# puts request.query_string        # ""
# puts request.content_length      # length of request.body
# puts request.media_type          # media type of request.body
# puts request.host                # "example.com"
# puts request.get?                # true (similar methods for other verbs)
# puts request.form_data?          # false
# puts request["some_param"]       # value of some_param parameter. [] is a shortcut to the params hash.
# puts request.referrer            # the referrer of the client or '/'
# puts request.user_agent          # user agent (used by :agent condition)
# puts request.cookies             # hash of browser cookies
# puts request.xhr?                # is this an ajax request?
# puts request.url                 # "http://example.com/example/foo"
# puts request.path                # "/example/foo"
# puts request.ip                  # client IP address
# puts request.secure?             # false (would be true over ssl)
# puts request.forwarded?          # true (if running behind a reverse proxy)
# puts request.env                 # raw env hash handed in by Rack
# puts request["size"]       # value of some_param parameter. [] is a shortcut to the params hash.