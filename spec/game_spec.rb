require 'game'
require 'board'
require 'human_player'

RSpec.describe Game do 
  let(:board){Board.new(%w[1 2 3 4 5 6 7 8 9])}
  let(:player1){HumanPlayer.new('X', 'Human')}
  let(:player2){HumanPlayer.new('O', 'Human')}
  subject(:game){described_class.new(board, player1, player2)}

  describe "#update_board" do 
    it 'should update the board with the correct marker' do 
      expect(game.update_board(%w[1 2 3 4 5 6 7 8 9], 'X', 1)).to eq(%w[X 2 3 4 5 6 7 8 9])
    end
  end

  describe "#valid_move?" do 
    it 'should verify if move is not valid if player picks zero' do
      expect(game.valid_move?(0, %w[1 2 3 4 5 6 7 8 9])).to eq(false)
    end

    it 'should verify if move valid if player picks 6' do
      expect(game.valid_move?(6, %w[1 2 3 4 5 6 7 8 9])).to eq(true)
    end
  end
end