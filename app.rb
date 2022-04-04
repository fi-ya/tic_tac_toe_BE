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
$app_builder = AppBuilder.new($grid)

get '/' do
  data = { 'grid' => $grid }
  data.to_json
end

get '/start-game' do
  new_grid = $app_builder.board.reset_grid
  reset_current_player = $app_builder.game.player1
  reset_current_player_marker = $app_builder.game.player1.marker
  
  response = { 
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
  winner = $app_builder.game.winning_player(grid)

  response = {
    'updated_grid' => updated_grid.to_s,
    'current_player_marker' => current_player_marker.to_s,
    'game_status' => game_status.to_s,
    'winner' => game_status == 'Won' ? winner.to_s : 'undefined'
  }
  response.to_json
end