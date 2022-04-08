require 'sinatra'
require 'sinatra/contrib/all'
require 'sinatra/cors'
require 'json'
require './lib/app_builder'
require './lib/board'
require './lib/game'
require './lib/human_player'
require './lib/player'
require './lib/game_mode'
require './lib/computer_player'

set :default_content_type, 'application/json'
set :allow_origin, '*'
set :allow_methods, 'GET,HEAD,POST,PUT,PATCH,OPTIONS'
set :allow_headers, 'content-type, if-modified-since, access-control-allow-origin'
set :expose_headers, 'location,link'

$app_builder = AppBuilder.new
# CHECK appBuilder initailased player 1 as human
p 'ONE player1 start:',$app_builder.player1

get '/' do
  "Hello World".strip
end

get '/start-game/:player1_token' do
  $app_builder.player1_token = params['player1_token'].to_i
  $app_builder.game.player1 = $app_builder.game_mode.set_player1($app_builder.player1_token)
  
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
  current_player = @request_payload[1]
  player_move = @request_payload[2].to_i
  player1 = $app_builder.game.player1
  player2 = $app_builder.game.player2

  updated_grid = $app_builder.game.take_turn(grid, current_player, player_move, player1, player2)
  current_player_marker = $app_builder.game.update_current_player(current_player, player1, player2)
  game_status = $app_builder.game.game_status(grid)
  winner = $app_builder.game.winning_player(grid, player1, player2)

  response = {
    'updated_grid' => updated_grid.to_s,
    'current_player_marker' => current_player_marker.to_s,
    'game_status' => game_status.to_s,
    'winner' => winner.to_s
  }
  response.to_json
end