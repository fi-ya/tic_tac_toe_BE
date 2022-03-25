class Message
  def welcome
    "Let's play Tic Tac Toe"
  end

  def ask_custom_marker
    "\nEnter one letter sign to identify you on the board eg. X, O, A \n"
  end

  def computer_mark(name, marker)
    "\nPlayer 1 (#{name}) chose #{marker} marker \n"
  end

  def player1_custom_marker(player1_name)
    "\nPlayer 1 (#{player1_name}) choose your custom marker: "
  end

  def player1_custom_marker_choice(player1_name, marker)
    "\nPlayer 1 (#{player1_name}) your marker is #{marker} \n"
  end

  def player2_custom_marker(player2_name)
    "\nPlayer 2 (#{player2_name}) choose your custom marker: "
  end

  def player2_custom_marker_choice(player2_name, marker)
    "\nPlayer 2 (#{player2_name}) your marker is #{marker} \n"
  end

  def error_custom_marker
    "\nMarker not available. Please enter a SINGLE alphabetic character.\n\n"
  end

  def show_current_player(marker, name)
    "\nPlayer #{marker} (#{name}) your turn to make a move...\n"
  end

  def enter_num
    "\nEnter a number between 1-9: "
  end

  def computer_thinking
    "\nComputer thinking... "
  end

  def players_move(marker, name, move)
    "\nPlayer #{marker} (#{name}) chose #{move} \n\n"
  end

  def invalid_move
    "\nInvalid move. Try again\n\n"
  end

  def tie
    "\nIt's a tie. Game Over!\n\n"
  end

  def won(player)
    "\nPlayer #{player} wins!\n\n"
  end

  def game_mode_selection
    "\nSelect a game:\n 1. Human vs Human\n 2. Computer vs Human\n\n"
  end

  def error_game_mode
    "\nInvalid option selected. Please try again:\n1. Human vs Human\n2. Computer vs Human\n\n"
  end

  def game_starting
    "\nGame starting... \n"
  end

  def replay_or_exit
    "Game Over!\n\n1.Play again\n2.Exit\n\n"
  end

  def error_play_again_exit
    "\nInvalid option selected. Please try again:\n1.Play again\n2.Exit\n\n"
  end

  def exit_msg
    "\nThanks for playing Tic Tac Toe!\n\n"
  end

  puts $LOAD_PATH
end
