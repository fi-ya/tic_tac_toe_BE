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

before do 
  board = Board.new
  message = Message.new
  input_validation = InputValidation.new
  display = Display.new(message, board, input_validation)
  game_mode = GameMode.new(display)
  game_controller = GameController.new(display, game_mode, message, board)
  player1 = HumanPlayer.new('X', 'Human', display)
  player2 = HumanPlayer.new('O', 'Human', display)
  @game = Game.new(board, display, player1, player2)
end

# before do
#   request.body.rewind
#   @request_payload = JSON.parse request.body.read
# end

# Endpoints
get "/" do
  data = { 'grid' => [1,2,3,4,5,6,7,8,9] }
  data.to_json
end

get "/start-game" do
  board = Board.new
  message = Message.new
  input_validation = InputValidation.new
  display = Display.new(message, board, input_validation)
  game_mode = GameMode.new(display)
  game_controller = GameController.new(display, game_mode, message, board)
  player1 = HumanPlayer.new('X', 'Human', display)
  player2 = HumanPlayer.new('O', 'Human', display)
  @game = Game.new(board, display, player1, player2)
  
  # game.start_game

  response = { 'message' => 'Player X turn' }
  response.to_json
end

post "/grid/:move" do
  # player_move = JSON.parse(request.body)
  # print "DATA player move=", player_move

  p "#{params['move']}"
 
  p "REQUEST BODY REWIND: ", request.body
  @request_payload = JSON.parse request.body.read
  p "REQUEST PAYLOAD: ",@request_payload.to_i

  p "Current player: ", @game.current_player.marker
  p "Cuurent board: ", @game.board.grid

  
  @game.play_turn(@game.current_player.marker, @request_payload.to_i)
  p "Update board: ", @game.board.grid
  p "Update current player: ", @game.current_player.marker
  
 
  response = { 'current_player' => @game.current_player.marker, 'grid' => @game.board.grid}
  p 'Grid Move response', response
  response.to_json
end

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