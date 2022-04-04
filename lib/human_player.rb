require_relative 'player'
class HumanPlayer < Player
  attr_accessor :marker, :name

  def initialize(marker, name)
    @marker = marker
    @name = name
  end
end
