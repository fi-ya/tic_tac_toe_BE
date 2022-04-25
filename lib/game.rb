require_relative 'board'
class Game
  attr_accessor :board, :current_player, :player1, :player2

  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
    @current_player = player1
  end

  def computer_move(grid)
    board.available_moves(grid)[0].to_i
  end

  def take_turn(grid, curr_player_marker, move, player1, player2)
    p "TAKE TURN:", grid, curr_player_marker, move, player1, player2
    play_turn(grid, curr_player_marker, move, player1, player2) unless game_over?(grid)
    grid
  end

  def play_turn(grid, curr_player_marker, move, player1, player2)
    p "PLAY TURN:", grid, curr_player_marker, move, player1, player2
    p "VALID MOVE PLAY TURN:", valid_move?(move)
    if valid_move?(move)
      update_board(grid, curr_player_marker, move, player1, player2)
    else
      'Invalid move. Try again'
    end
  end

  def update_board(grid, curr_player_marker, move, player1, player2)
    p "UPDATE BAORD:", grid, curr_player_marker, move, player1, player2
    if curr_player_marker == player1.marker
      board.mark_board(grid, player1.marker, move)
    else
      board.mark_board(grid, player2.marker, move)
    end
  end

  def update_current_player(curr_player_marker, player1, player2)
    curr_player_marker == player1.marker ? set_current_player(player2) : set_current_player(player1)
  end

  def set_current_player(current_player)
    @current_player = current_player
  end

  def game_over?(grid)
    board.board_full?(grid) || board.win?(grid)
  end

  def game_status(grid)
    p "game status grid:", grid
    p "board full?", !board.board_full?(grid)
    p "win board:", !board.win?(grid)
    if !board.board_full?(grid) && !board.win?(grid)
      'Keep playing'
    elsif board.board_full?(grid) && !board.win?(grid)
      'Tie'
    else
      'Won'
    end
  end

  def winning_player(grid, player1, player2)
    p "winning_player: ", grid, player1, player2
    grid.count(player1.marker) > grid.count(player2.marker) ? player1.marker : player2.marker
  end

  def valid_move?(move)
    move[0] === :empty
  end
end
