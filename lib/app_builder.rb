require_relative 'board'
require_relative 'game'
require_relative 'human_player'
require_relative 'computer_player'
require_relative 'player'
require_relative 'game_mode'

class AppBuilder
  attr_accessor :board, :game_mode, :player1, :player2, :game, :player1_token

  def initialize(grid)
    @board = Board.new(grid)
    @game_mode = GameMode.new
    @player1_token = 1
    # @player1 = HumanPlayer.new('X', 'Human')
    @player1 = game_mode.set_player1(player1_token)
    @player2 = HumanPlayer.new('O', 'Human')
    @game = Game.new(board, player1, player2)
  end
end
