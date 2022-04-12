require_relative 'human_player'
require_relative 'computer_player'

class GameMode
  def set_player1(game_mode_chosen)
    case game_mode_chosen
    when 1
      HumanPlayer.new('X', 'Human')
    when 2
      ComputerPlayer.new('X', 'Computer')
    end
  end
end
