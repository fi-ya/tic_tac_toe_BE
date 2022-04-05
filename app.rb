require 'sinatra'
require 'sinatra/contrib/all'
require 'sinatra/cors'
require 'json'
require './lib/app_builder'
require './lib/board'
require './lib/game'
require './lib/human_player'
require './lib/player'

set :default_content_type, 'application/json'
set :allow_origin, 'http://localhost:3000'
set :allow_methods, 'GET,HEAD,POST,PUT,PATCH'
set :allow_headers, 'content-type, if-modified-since, access-control-allow-origin'
set :expose_headers, 'location,link'

$grid = %w[1 2 3 4 5 6 7 8 9]
$player1_token = 1
$app_builder = AppBuilder.new($grid, $player1_token)

p 'player1 start:',$app_builder.player1

get '/' do
  data = { 'grid' => $grid }
  data.to_json
end

# get '/start-game' do
#   new_grid = $app_builder.board.reset_grid
#   reset_current_player = $app_builder.game.player1
#   reset_current_player_marker = $app_builder.game.player1.marker
  
#   response = { 
#     'reset_current_player_marker' => reset_current_player_marker.to_s, 
#     'new_grid' => new_grid.to_s 
#   }
#   response.to_json
# end

get '/start-game/:player1_token' do
  player1_token = params['player1_token']
  p 'player1_token:',player1_token
  
  player1 = $app_builder.player1
  p 'player1:', player1
  p 'player1 GET:',$app_builder.player1

  player123 = $app_builder.game_mode.set_player1(player1_token)
  p 'player1 UPDATE:', player123
  # p 'reset_current_player:', reset_current_player
  p 'player1 GET:',$app_builder.player1
  
  reset_current_player_marker = $app_builder.game.player1.marker
  new_grid = $app_builder.board.reset_grid
  
  response = { 
    'reset_current_player1_name' => $app_builder.game.player1.name,
    'reset_current_player_marker' => reset_current_player_marker.to_s, 
    'new_grid' => new_grid.to_s 
  }
  response.to_json
end

put '/start-game/grid' do
  @request_payload = JSON.parse request.body.read

  grid = @request_payload[0]
  player = @request_payload[1]
  player_move = @request_payload[2].to_i

  updated_grid = $app_builder.game.take_turn(grid, player, player_move)
  current_player_marker = $app_builder.game.update_current_player(player, $app_builder.game.player1, $app_builder.game.player2)
  game_status = $app_builder.game.game_status(grid)

  response = {
    'updated_grid' => updated_grid.to_s,
    'current_player_marker' => current_player_marker.to_s,
    'game_status' => game_status.to_s,
  }
  response.to_json
end

get '/start-game/grid/:winning_grid' do
  grid = params['winning_grid']
  winner = $app_builder.game.winning_player(grid)

  response = {
    'winner' =>  winner.to_s 
  }
  response.to_json
end