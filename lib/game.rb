require_relative 'board'
class Game
  attr_accessor :board, :current_player
  attr_reader :player1, :player2

  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
    @current_player = player1
  end

  # def start_game(player, move)
  #   board.reset_grid
  #   take_turn(player, move)
  # end

  def take_turn(player, move)
    if !game_over?
      play_turn(player, move)
      game_status
    end 
  end

  def play_turn(player, move)
    if valid_move?(move)
      update_board(player, move)
      update_current_player
    else
      "Invalid move. Try again"
    end
  end

  def update_board(player, move)
    player == player1.marker ? board.mark_board(player1.marker, move) : board.mark_board(player2.marker, move)
  end

  def update_current_player
    current_player == player1 ? set_current_player(player2) : set_current_player(player1)
  end

  def set_current_player(current_player)
    @current_player = current_player
  end

  def game_over?
    board.board_full? || board.win?
  end

  def game_status
    if !board.board_full? && !board.win?
      "Keep playing"
    elsif board.board_full? && !board.win?
      "Tie"
    else
      "Won"
    end
  end

  def winning_player
    board.grid.count(player1.marker) > board.grid.count(player2.marker) ? player1.marker : player2.marker
  end

  # private

  def valid_move?(index)
    !board.position_taken?(index) && index.between?(1, 9)
  end
end
