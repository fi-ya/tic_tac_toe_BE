require_relative 'display'
require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class CustomMarker
  attr_reader :display
  attr_accessor :player1, :player2, :player1_marker, :player2_marker

  def initialize(display, player1, player2)
    @display = display
    @player1 = player1
    @player2 = player2
  end

  def choose_custom_marker
    display.ask_custom_marker
    get_player1_custom_marker
    get_player2_custom_marker
    set_player1_custom_marker
    set_player2_custom_marker
  end

  def get_player1_custom_marker
    if player1.name == 'Computer'
      display.computer_mark(player1.name, player1.marker)
      nil
    else
      display.player1_custom_marker(player1.name)
      display.get_custom_marker1_choice
      @player1_marker = display.validate_custom_marker1_choice
      display.print_player1_custom_marker_choice(player1.name)
    end
  end

  def get_player2_custom_marker
    display.print_player2_custom_marker(player2.name)
    display.get_custom_marker2_choice
    @player2_marker = display.validate_custom_marker2_choice
    display.print_player2_custom_marker_choice(player2.name)
  end

  def set_player1_custom_marker
    if player1.name == 'Computer'
      nil
    else
      player1.marker = player1_marker
    end
  end

  def set_player2_custom_marker
    player2.marker = player2_marker
  end
end
