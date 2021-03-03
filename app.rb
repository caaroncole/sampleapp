# app.rb


require 'sinatra'
 
get '/' do
  content_type 'text/html'
  
  t = %w[text/css text/html application/javascript]
  puts request.accept              # ['text/html', '*/*']
  puts request.accept? 'text/xml'  # true
  puts request.preferred_type(t)   # 'text/html'
  puts request.body                # request body sent by the client (see below)
  puts request.scheme              # "http"
  puts request.script_name         # "/example"
  puts request.path_info           # "/foo"
  puts request.port                # 80
  puts request.request_method      # "GET"
  puts request.query_string        # ""
  puts request.content_length      # length of request.body
  puts request.media_type          # media type of request.body
  puts request.host                # "example.com"
  puts request.get?                # true (similar methods for other verbs)
  puts request.form_data?          # false
  puts request["some_param"]       # value of some_param parameter. [] is a shortcut to the params hash.
  puts request.referrer            # the referrer of the client or '/'
  puts request.user_agent          # user agent (used by :agent condition)
  puts request.cookies             # hash of browser cookies
  puts request.xhr?                # is this an ajax request?
  puts request.url                 # "http://example.com/example/foo"
  puts request.path                # "/example/foo"
  puts request.ip                  # client IP address
  puts request.secure?             # false (would be true over ssl)
  puts request.forwarded?          # true (if running behind a reverse proxy)
  puts request.env                 # raw env hash handed in by Rack

  "Hello, world"

end



