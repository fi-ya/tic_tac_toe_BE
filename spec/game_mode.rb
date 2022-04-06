require 'game_mode'
require 'human_player'
require 'computer_player'

RSpec.describe GameMode do

  subject(:game_mode){ described_class.new}

  describe "#set_player1" do 
    context 'human player'
      it 'should be created when player uses number 1 token' do 
        expect(game_mode.set_player1(1)).to eq( HumanPlayer.new('X', 'Human'))
      end
    end

    context 'computer player'
      it 'should be created when player uses number 2 token' do 
        expect(game_mode.set_player1(2)).to eq( HumanPlayer.new('X', 'Computer'))
      end
    end
  end
end