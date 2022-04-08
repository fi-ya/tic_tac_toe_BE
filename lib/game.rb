require_relative 'board'
class Game
  attr_accessor :board, :current_player, :player1, :player2

  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
    @current_player = player1
  end

  def take_turn(grid, player, move, player1, player2)
      play_turn(grid, player, move, player1, player2) unless game_over?(grid)
  end

  def play_turn(grid, player, move, player1, player2)
    if valid_move?(move, grid)
      update_board(grid, player, move, player1, player2)
    else
      'Invalid move. Try again'
    end
  end

  def update_board(grid, player, move, player1, player2)
    if player == player1.marker
      board.mark_board(grid, player1.marker, move)
    else
      board.mark_board(grid, player2.marker, move)
    end
  end

  def update_current_player(current_player, player1, player2)
    current_player == player1.marker ? set_current_player(player2.marker) : set_current_player(player1.marker)
  end

  def set_current_player(current_player)
    @current_player = current_player
  end

  def game_over?(grid)
    board.board_full?(grid) || board.win?(grid)
  end

  def game_status(grid)
    if !board.board_full?(grid) && !board.win?(grid)
      'Keep playing'
    elsif board.board_full?(grid) && !board.win?(grid)
      'Tie'
    else
      'Won'
    end
  end

  def winning_player(grid, player1, player2)
    grid.count(player1.marker) > grid.count(player2.marker) ? player1.marker : player2.marker
  end

  def valid_move?(index, grid)
    !board.position_taken?(index, grid) && index.between?(1, 9)
  end
end
