require_relative 'board'
require_relative 'message'
require_relative 'input_validation'
require_relative 'display'
require_relative 'game'
require_relative 'game_mode'
require_relative 'computer_player'
require_relative 'human_player'
require_relative 'game_controller'
class AppBuilder
    attr_accessor :board, :message, :input_validation, :display, :game_mode, :game_controller, :player1, :player2, :game
  
    def initialize
      @board = Board.new
      @message = Message.new
      @input_validation = InputValidation.new
      @display = Display.new(message, board, input_validation)
      @game_mode = GameMode.new(display)
      @game_controller = GameController.new(display, game_mode, message, board)
      @player1 = HumanPlayer.new('X', 'Human', display)
      @player2 = HumanPlayer.new('O', 'Human', display)
      @game = Game.new(board, display, player1, player2)
    end
end