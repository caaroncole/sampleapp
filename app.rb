# app.rb


require 'sinatra'
 
get '/' do
  content_type 'text/html'
  "Hello, world"
end



