require_relative 'board'
class Game
  attr_reader :board, :display, :player1, :player2, :current_player

  def initialize(board, display, player1, player2)
    @board = board
    @display = display
    @player1 = player1
    @player2 = player2
    @current_player = player1
  end

  # def start_game
  #   board.reset_grid
  #   take_turn
  # end

  def take_turn
    until game_over?
      # prompt_player
      play_turn(current_player, current_player_move)
    end
    game_status
  end

  # def prompt_player
  #   if current_player.name == 'Computer'
  #     "Computer thinking... "
  #   else
  #     "Enter a number between 1-9: " unless game_over?
  #   end
  # end

  def play_turn(player, move)
    if valid_move?(move)
      update_board(player, move)
      update_current_player
    else
      "Invalid move. Try again"
    end
  end

  def update_board(player, move)
    player == player1 ? board.mark_board(player1.marker, move) : board.mark_board(player2.marker, move)
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
    if board.board_full? && !board.win?
      "It's a tie. Game Over!"
    else
      "Player wins!"
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
