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
  p "reset_current_player_marker", reset_current_player_marker
  new_grid = $app_builder.board.reset_grid
  converted_grid = $app_builder.board.convert_sqaures_to_JSON(new_grid)

  response = {
    'player1_name' => $app_builder.game.player1.name,
    'player1_marker' => reset_current_player_marker.to_s,
    'new_grid' => converted_grid.to_s
  }
  response.to_json
end

put '/start-game/grid' do
  @request_payload = JSON.parse request.body.read
  p "HUM request payload", @request_payload
  grid = @request_payload[0]
  current_player_marker = @request_payload[1]
  player_move = @request_payload[2]
  player1 = $app_builder.game.player1
  player2 = $app_builder.game.player2

  convert_grid_with_state = $app_builder.board.convert_grid_with_state(grid)
  convert_player_move_to_state = $app_builder.board.convert_square_with_state(player_move[0])
  player_move[0] = convert_player_move_to_state
  player_move[1] = player_move[1].to_i
  # p "player_move", player_move
  # p "convert_grid_with_state", convert_grid_with_state
  # p "availablemoves", $app_builder.board.available_moves(convert_grid_with_state)
  # p "convert_player_move_to_state", convert_player_move_to_state
  # p "mark board", $app_builder.board.mark_board(convert_grid_with_state, current_player_marker, player_move)
  # p "game ove?", $app_builder.game.game_over?(convert_grid_with_state)

  updated_grid_state = $app_builder.game.take_turn(convert_grid_with_state, current_player_marker, player_move, player1, player2)
  # p "updated_grid_state ++", updated_grid_state
  # updated_current_player = $app_builder.game.update_current_player(current_player_marker, player1, player2)
 
  updated_grid = $app_builder.board.convert_sqaures_to_JSON(updated_grid_state)
  # p "updated grid=>", updated_grid
  current_player_name = $app_builder.game.current_player.name
  current_player_marker = $app_builder.game.current_player.marker
  game_status = $app_builder.game.game_status(updated_grid_state)
  winner = $app_builder.game.winning_player(updated_grid, player1, player2)
  invalid_move =  $app_builder.game.invalid_move?(player_move)

  # p "RESPONSE:",  updated_grid.to_s, current_player_name.to_s,current_player_marker.to_s,game_status.to_s,winner.to_s, invalid_move.to_s
  response = {
    'updated_grid' => updated_grid.to_s,
    'current_player_name' => current_player_name.to_s,
    'current_player_marker' => current_player_marker.to_s,
    'game_status' => game_status.to_s,
    'winner' => winner.to_s,
    'invalid_move' => invalid_move
  }
  response.to_json
end

put '/start-game/computer_move' do
  @request_payload = JSON.parse request.body.read
  p "COMP request payload", @request_payload

  grid = JSON.parse @request_payload[0]
  current_player_marker = @request_payload[1]
  player1 = $app_builder.game.player1
  player2 = $app_builder.game.player2

  convert_grid_with_state = $app_builder.board.convert_grid_with_state(grid)
  p "COMP convert_grid_with_state", convert_grid_with_state

  computer_move = $app_builder.game.computer_move(convert_grid_with_state)
  p "COMP computer_move", computer_move

  updated_grid_state = $app_builder.game.take_turn(convert_grid_with_state, current_player_marker, computer_move, player1, player2)
  p "COMP updated_grid_state", updated_grid_state
  # updated_current_player = $app_builder.game.update_current_player(current_player_marker, player1, player2)

  updated_grid = $app_builder.board.convert_sqaures_to_JSON(updated_grid_state)
  p "COMP updated_grid", updated_grid
  current_player_name = $app_builder.game.current_player.name
  current_player_marker = $app_builder.game.current_player.marker
  game_status = $app_builder.game.game_status(updated_grid_state)
  winner = $app_builder.game.winning_player(updated_grid, player1, player2)
  invalid_move =  $app_builder.game.invalid_move?(computer_move)

  p "COMP RESPONSE:",  updated_grid.to_s, current_player_name.to_s,current_player_marker.to_s,game_status.to_s,winner.to_s, invalid_move.to_s
  response = {
    'updated_grid' => updated_grid.to_s,
    'current_player_name' => current_player_name.to_s,
    'current_player_marker' => current_player_marker.to_s,
    'game_status' => game_status.to_s,
    'winner' => winner.to_s,
    'invalid_move' => invalid_move
  }
  response.to_json
end
