require 'sinatra'
require 'sinatra/contrib/all'
require 'sinatra/cors'
require 'json'
require './lib/board'
require './lib/human_player'
require './lib/game'
require './lib/app_builder'

set :default_content_type, 'application/json'
set :allow_origin, "http://localhost:3000"
set :allow_methods, "GET,HEAD,POST,PUT,PATCH"
set :allow_headers, "content-type, if-modified-since, access-control-allow-origin" 
set :expose_headers, "location,link"

$grid = %w[1 2 3 4 5 6 7 8 9]
$app_builder = AppBuilder.new($grid)

# Endpoints
get "/" do
  # data = { 'grid' => $grid }
  # data.to_json
end

get "/start-game" do
  new_grid = $app_builder.board.reset_grid
  reset_current_player = $app_builder.game.player1
  reset_current_player_marker = $app_builder.game.player1.marker
  response = { 'reset_current_player' => "#{reset_current_player}", 'reset_current_player_marker' => "#{reset_current_player_marker}", 'new_grid' => "#{new_grid}" }
  response.to_json
end

get "/start-game/grid" do

end

put "/start-game/grid" do
  @request_payload = JSON.parse request.body.read
  p "REQUEST PAYLOAD: ",@request_payload
  
  grid = @request_payload[0]
  player = @request_payload[1]
  player_move = @request_payload[2].to_i

  updated_grid =  $app_builder.game.take_turn(grid, player, player_move)
  p "UPDATED_GRID:", updated_grid 

  current_player_marker =  $app_builder.game.update_current_player(player,$app_builder.game.player1, $app_builder.game.player2 )
  p "current_playerMARKER", current_player_marker
 
  game_status = $app_builder.game.game_status(grid)
  winner = $app_builder.game.winning_player(grid)

  response = { 
    'updated_grid' => "#{updated_grid}",
    'current_player_marker' => "#{current_player_marker}", 
    'game_status'=> "#{game_status}", 
    'winner' => "#{winner}"
    }
  p 'Grid Move response', response
  response.to_json
end

# get '/game-mode' do
#   data = JSON.parse(request.body).string
#   # res = { "request" => data}
#   print res , "DATAAA"
#   # "#{res}"
# end

# post '/game-mode' do
#   # returns a stringIO <StringIO:0x0000000113084ad0>
#   @data = request.body.string
#   print "DATA=", @data
#   # set_player = game_mode.set_player1(@data)
#   # p "SET PLAYER:", set_player
 
#   response = { 'mode' => @data }
#   response.to_json
# end