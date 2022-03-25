require 'sinatra'
require 'sinatra/contrib/all'
require 'sinatra/cors'
require 'json'

set :default_content_type, 'application/json'

set :allow_origin, "http://localhost:3000"
set :allow_methods, "GET,HEAD,POST"
set :allow_headers, "content-type,if-modified-since"
set :expose_headers, "location,link"
# set :show_exceptions, ""

# Endpoints
get "/" do
    '{"game": "?"}'
end

get "/welcome" do
  message = Message.new
  welcome = message.welcome
  
  data = { 'welcome' => welcome }
  data.to_json
end

get "/grid" do
  board = Board.new
  grid = board.reset_grid
  
  data = { 'grid' => grid }
  data.to_json
end
