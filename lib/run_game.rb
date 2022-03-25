require_relative 'board'
require_relative 'display'
require_relative 'game'
require_relative 'message'
require_relative 'computer_player'
require_relative 'human_player'
require_relative 'game_mode'
require_relative 'game_controller'

def start_game
  board = Board.new
  message = Message.new
  input_validation = InputValidation.new
  display = Display.new(message, board, input_validation)
  game_mode = GameMode.new(display)
  game_controller = GameController.new(display, game_mode, message, board)

  game_controller.start_session
end

start_game
