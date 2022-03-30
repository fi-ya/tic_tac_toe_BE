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

#  global variables
$app_builder = AppBuilder.new(%w[1 2 3 4 5 6 7 8 9])
p "APP BUILDER:", $app_builder

before do
  # $app_builder =  AppBuilder.new(%w[1 2 3 4 5 6 7 8 9])
  # request.body.rewind
  # @request_payload = JSON.parse request.body.read
end

# Endpoints
get "/" do
  data = { 'grid' => [1,2,3,4,5,6,7,8,9] }
  data.to_json
end

get "/start-game" do
  # board = Board.new(%w[1 2 3 4 5 6 7 8 9])
  # player1 = HumanPlayer.new('X', 'Human')
  # player2 = HumanPlayer.new('O', 'Human')
  # @game = Game.new(board, player1, player2)

  # get NameError - uninitialized constant AppBuilder
  # @app_builder =  AppBuilder.new(%w[1 2 3 4 5 6 7 8 9])

  response = { 'current_player' => $app_builder.game.current_player.marker }
  response.to_json
end

get "/start-game/grid" do
  response = { 'current_player' => @game.current_player.marker, 'grid' => @game.board.grid}
  response.to_json
end

put "/start-game/grid" do
  # message = Message.new
  # board = Board.new(game.board.grid)
  # input_validation = InputValidation.new
  # display = Display.new(message, board, input_validation)
  # player1 = HumanPlayer.new('X', 'Human', display)
  # player2 = HumanPlayer.new('O', 'Human', display)
  # @game = Game.new(board, display, player1, player2)

  # p "#{params['move']}"
 
  p "REQUEST BODY REWIND: ", request.body
  @request_payload = JSON.parse request.body.read
  p "REQUEST PAYLOAD: ",@request_payload

  p "Current player, move ", @request_payload[0], @request_payload[1].to_i

  # inital method - but kept returning O marker
  # @game.play_turn(@request_payload[0], @request_payload[1].to_i)

  $app_builder.board.mark_board(@request_payload[0], @request_payload[1].to_i)
  $app_builder.game.update_current_player

  # p "Update board: ", @game.board.grid
  # p "Update current player: ", @game.current_player.marker
  
  response = { 'current_player' => $app_builder.game.current_player.marker, 'grid' => $app_builder.game.board.grid}
  p 'Grid Move response', response
  response.to_json
end


# post "/grid/:move" do
 
#   p "REQUEST BODY REWIND: ", request.body
#   @request_payload = JSON.parse request.body.read
#   p "REQUEST PAYLOAD: ",@request_payload.to_i

#   @game.play_turn(@game.current_player.marker, @request_payload.to_i)
  
#   response = { 'current_player' => @game.current_player.marker, 'grid' => @game.board.grid}
#   response.to_json
# end

# get "/grid" do
#   board = Board.new
#   grid = board.reset_grid
  
#   data = { 'grid' => grid }
#   data.to_json
# end

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