# require 'sinatra'
require 'sinatra/base'
require 'sinatra/contrib/all'
require 'sinatra/cors'
# require 'sinatra/cross_origin'
require 'json'
require './lib/app_builder'
require './lib/board'
require './lib/game'
require './lib/human_player'
require './lib/player'
require './lib/game_mode'
require './lib/computer_player'

class App < Sinatra::Base
  
  # register Sinatra::CrossOrigin
  # set :bind, '0.0.0.0'

  register Sinatra::Cors
  set :default_content_type, 'application/json'
  set :allow_origin, '*'
  set :allow_methods, 'GET,HEAD,POST,PUT,PATCH,OPTIONS'
  set :allow_headers, 'content-type, if-modified-since, access-control-allow-origin'
  set :expose_headers, 'location,link'

  # configure do
  #   enable :cross_origin
  #   # enable :method_override
  # end

  # before do
  #   # p 'BEFORE'
  #   # halt 200 if request.request_method == 'OPTIONS'
  #   # p 'AFTER'
  #   response.headers['Access-Control-Allow-Origin'] = '*'
  # end

  $app_builder = AppBuilder.new
  # CHECK appBuilder initailased player 1 as human
  p 'ONE player1 start:',$app_builder.player1

  # get '/' do
  #   data = { 'grid' => "world" }
  #   data.to_json
  # end

  get '/start-game/:player1_token' do
    response.headers['Access-Control-Allow-Origin'] = '*'

    $app_builder.player1_token = params['player1_token'].to_i
    $app_builder.game.player1 = $app_builder.game_mode.set_player1($app_builder.player1_token)

    reset_current_player_marker = $app_builder.game.player1.marker
    new_grid = $app_builder.board.reset_grid
    
    response = { 
      'reset_current_player1_name' => $app_builder.game.player1.name,
      'reset_current_player_marker' => reset_current_player_marker.to_s, 
      'new_grid' => new_grid.to_s 
      # 'hello' => 'world'
    }
    response.to_json
  end

  # put '/start-game/grid' do
  #   @request_payload = JSON.parse request.body.read

  #   grid = @request_payload[0]
  #   player = @request_payload[1]
  #   player_move = @request_payload[2].to_i

  #   updated_grid = $app_builder.game.take_turn(grid, player, player_move)
  #   current_player_marker = $app_builder.game.update_current_player(player, $app_builder.game.player1, $app_builder.game.player2)
  #   game_status = $app_builder.game.game_status(grid)

  #   response = {
  #     'updated_grid' => updated_grid.to_s,
  #     'current_player_marker' => current_player_marker.to_s,
  #     'game_status' => game_status.to_s,
  #   }
  #   response.to_json
  # end

  # get '/start-game/grid/:winning_grid' do
  #   grid = params['winning_grid']
  #   winner = $app_builder.game.winning_player(grid)

  #   response = {
  #     'winner' =>  winner.to_s 
  #   }
  #   response.to_json
  # end

  # options "*" do
  #   response.headers["Allow"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"
  #   response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
   
  #   200
  # end
  # options "*" do
  #   response.headers["Allow"] = "GET,PUT,POST,DELETE,OPTIONS"
  #   response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
  #   response.headers["Access-Control-Allow-Origin"] = "http://localhost:3000"
  #   200
  # end
  
end