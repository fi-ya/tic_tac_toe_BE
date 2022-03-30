require_relative 'player'
# require_relative 'display'
class HumanPlayer < Player
  attr_accessor :marker, :name

  def initialize(marker, name)
    @marker = marker
    @name = name
  end

  # def get_move
  #   display.human_player_move(marker, name)
  # end
end
