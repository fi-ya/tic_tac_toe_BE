require 'game_mode'
require 'human_player'
require 'computer_player'

RSpec.describe GameMode do

  subject(:game_mode){ described_class.new}

  describe "#set_player1" do 
    it 'should create human player when player uses number 1 token' do 
      expect(game_mode.set_player1(1)).to eq( HumanPlayer.new('X', 'Human'))
    end

    it 'should be create computer player when player uses number 2 token' do 
      expect(game_mode.set_player1(2)).to eq( ComputerPlayer.new('X', 'Computer'))
    end
  end
end