class InputValidation
  VALID_GAME_MODES = [1, 2].freeze
  VALID_PLAY_AGAIN = [1, 2].freeze
  VALID_CUSTOM_MARKER_LENGTH = 1
  COMPUTER_MARKER = 'X'

  def game_mode?(choice)
    VALID_GAME_MODES.include?(choice)
  end

  def play_again?(choice)
    VALID_PLAY_AGAIN.include?(choice)
  end

  def not_single_char?(marker)
    marker.length != VALID_CUSTOM_MARKER_LENGTH
  end

  def number?(marker)
    marker.count('0-9').positive?
  end

  def comp_marker?(marker)
    marker == COMPUTER_MARKER
  end

  def valid_custom_marker?(marker)
    !not_single_char?(marker) && !number?(marker)
  end

  def valid_custom_marker2?(custom_marker2, custom_marker1)
    valid_custom_marker?(custom_marker2) && !marker_taken?(custom_marker2,
                                                           custom_marker1) && !comp_marker?(custom_marker2)
  end

  def marker_taken?(custom_marker2, custom_marker1)
    custom_marker2 == custom_marker1
  end
end
