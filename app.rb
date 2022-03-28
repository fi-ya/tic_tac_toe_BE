require 'sinatra'
require 'sinatra/contrib/all'
require 'sinatra/cors'
require 'json'

set :default_content_type, 'application/json'

set :allow_origin, "http://localhost:3000"
set :allow_methods, "GET,HEAD,POST"
set :allow_headers, "content-type, if-modified-since, access-control-allow-origin, content-type" 
set :expose_headers, "location,link"
# set :show_exceptions, ""

# Endpoints
get "/" do
    '{"game": "?"}'
end

# get "/welcome" do
#   message = Message.new
#   welcome = message.welcome
  
#   data = { 'welcome' => welcome }
#   data.to_json
# end

get "/grid" do
  board = Board.new
  grid = board.reset_grid
  
  data = { 'grid' => grid }
  data.to_json
end

get '/game-mode' do
  data = JSON.parse(request.body).string
  # res = { "request" => data}
  print res , "DATAAA"
  # "#{res}"
end

post '/game-mode' do
  # returns a stringIO <StringIO:0x0000000113084ad0>
  @data = request.body.string
  print "DATA=", @data
  # set_player = game_mode.set_player1(@data)
  # p "SET PLAYER:", set_player
 
  response = { 'mode' => @data }
  response.to_json
end