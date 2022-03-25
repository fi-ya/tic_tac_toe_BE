require_relative 'display'
require_relative 'game'
require_relative 'game_mode'
require_relative 'human_player'
require_relative 'board'
require_relative 'message'
require_relative 'custom_marker'

class GameController
  attr_accessor :display, :game_mode, :player1, :player2, :game, :message, :board, :custom_marker

  def initialize(display, game_mode, message, board)
    @display = display
    @game_mode = game_mode
    @message = message
    @board = board
  end

  def start_session
    create_game
    start_game
    replay_exit_option
  end

  def create_game
    display.clear_terminal
    display.welcome

    player1_token = game_mode.select_game_mode
    @player1 = game_mode.set_player1(player1_token)
    @player2 = HumanPlayer.new('O', 'Human', display)

    @custom_marker = CustomMarker.new(display, player1, player2)
    custom_marker.choose_custom_marker

    @game = Game.new(board, display, player1, player2)
  end

  def start_game
    display.clear_terminal
    display.print_message(message.game_starting)
    game.start_game
  end

  def replay_exit_option
    display.print_message(message.replay_or_exit)
    display.get_play_exit_choice
    replay_or_exit(display.validate_play_again_choice)
  end

  def replay_or_exit(play_again_choice)
    if play_again_choice == 1
      create_game
      start_game
      replay_exit_option
    else
      display.clear_terminal
      display.print_message(message.exit_msg)
    end
  end
end
