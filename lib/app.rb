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

get '/start-game/:game_mode_token' do
  $app_builder.game_mode_token = params['game_mode_token'].to_i
  $app_builder.game.player1 = $app_builder.game_mode.set_player1($app_builder.game_mode_token)

  reset_current_player_marker = $app_builder.game.player1.marker
  new_grid = $app_builder.board.reset_grid

  response = {
    'player1_name' => $app_builder.game.player1.name,
    'player1_marker' => reset_current_player_marker.to_s,
    'new_grid' => new_grid.to_s
  }
  response.to_json
end

put '/start-game/grid' do
  @request_payload = JSON.parse request.body.read

  grid = @request_payload[0]
  current_player_marker = @request_payload[1]
  player_move = @request_payload[2].to_i
  player1 = $app_builder.game.player1
  player2 = $app_builder.game.player2

  updated_grid = $app_builder.game.take_turn(grid, current_player_marker, player_move, player1, player2)
  updated_current_player = $app_builder.game.update_current_player(current_player_marker, player1, player2)

  current_player_name = $app_builder.game.current_player.name
  current_player_marker = $app_builder.game.current_player.marker
  game_status = $app_builder.game.game_status(grid)
  winner = $app_builder.game.winning_player(grid, player1, player2)

  response = {
    'updated_grid' => updated_grid.to_s,
    'current_player_name' => current_player_name.to_s,
    'current_player_marker' => current_player_marker.to_s,
    'game_status' => game_status.to_s,
    'winner' => winner.to_s
  }
  response.to_json
end

put '/start-game/computer_move' do
  @request_payload = JSON.parse request.body.read

  grid = JSON.parse @request_payload[0]
  current_player_marker = @request_payload[1]
  player1 = $app_builder.game.player1
  player2 = $app_builder.game.player2

  computer_move = $app_builder.game.computer_move(grid)

  updated_grid = $app_builder.game.take_turn(grid, current_player_marker, computer_move, player1, player2)
  updated_current_player = $app_builder.game.update_current_player(current_player_marker, player1, player2)

  current_player_name = $app_builder.game.current_player.name
  current_player_marker = $app_builder.game.current_player.marker
  game_status = $app_builder.game.game_status(grid)
  winner = $app_builder.game.winning_player(grid, player1, player2)

  response = {
    'updated_grid' => updated_grid.to_s,
    'current_player_name' => current_player_name.to_s,
    'current_player_marker' => current_player_marker.to_s,
    'game_status' => game_status.to_s,
    'winner' => winner.to_s
  }
  response.to_json
end
