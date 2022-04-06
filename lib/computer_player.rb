require_relative 'player'

class ComputerPlayer < Player
  attr_accessor :marker, :name

  def initialize(marker, name)
    @marker = marker
    @name = name
  end
end
