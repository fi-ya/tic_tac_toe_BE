require_relative 'board'
require_relative 'game'
require_relative 'human_player'
require_relative 'computer_player'
require_relative 'player'
require_relative 'game_mode'

class AppBuilder
  attr_accessor :board, :game_mode, :player1, :player2, :game, :game_mode_token

  def initialize
    @board = Board.new
    @game_mode = GameMode.new
    @game_mode_token = 1
    @player1 = game_mode.set_player1(game_mode_token)
    @player2 = HumanPlayer.new('O', 'Human')
    @game = Game.new(board, player1, player2)
  end
end
