require_relative 'player'

class ComputerPlayer < Player
  
  def initialize(marker, name)
    @marker = marker
    @name = name
  end
end
