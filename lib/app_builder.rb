require_relative 'board'
require_relative 'game'
require_relative 'computer_player'
require_relative 'human_player'

class AppBuilder
    attr_accessor :board, :player1, :player2, :game
  
    def initialize(grid)
      @board = Board.new(grid)
      @player1 = HumanPlayer.new('X', 'Human')
      @player2 = HumanPlayer.new('O', 'Human')
      @game = Game.new(board, player1, player2)
    end
end