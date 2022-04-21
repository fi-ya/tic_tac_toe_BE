require_relative 'player'
class HumanPlayer < Player
  def initialize(marker, name)
    @marker = marker
    @name = name
  end
end
