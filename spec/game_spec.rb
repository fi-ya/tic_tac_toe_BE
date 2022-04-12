require 'game'
require 'board'
require 'human_player'

RSpec.describe Game do 
  let(:board){Board.new}
  let(:player1){HumanPlayer.new('X', 'Human')}
  let(:player2){HumanPlayer.new('O', 'Human')}
  let(:current_player){HumanPlayer.new('X', 'Human')}
  subject(:game){described_class.new(board, player1, player2)}

  describe "#play_turn" do 
    context 'invalid move' do 
      it 'should return an error message' do 
        expect(game.play_turn(%w[X O 3 4 5 6 7 8 9], 'X', 2, player1, player2)).to eq('Invalid move. Try again')
      end
    end
  end

  describe "#update_board" do 
    it 'should update the board with the correct marker' do 
      expect(game.update_board(%w[1 2 3 4 5 6 7 8 9], 'X', 1, player1, player2)).to eq(%w[X 2 3 4 5 6 7 8 9])
    end
  end
  describe "#update_current_player" do
    context 'set and update current player correctly' do
      it 'should update current player marker correctly to O' do
        expect(game.update_current_player('X', player1, player2)).to eq('O')
      end

      it 'should update current player marker correctly to X' do
        expect(game.update_current_player('O', player1, player2)).to eq('X')
      end
    end
  end

  describe "#game_over?" do 
    context "game over" do
      it 'should return a true boolean value' do
        expect(game.game_over?(%w[X X X O O 6 7 8 9])).to eq(true)
        expect(game.game_over?(%w[1 2 3 X X X 7 O O])).to eq(true)
        expect(game.game_over?(%w[1 2 3 O O 6 X X X])).to eq(true)
        expect(game.game_over?(%w[X 2 3 X O O X 8 9])).to eq(true)
        expect(game.game_over?(%w[O X O 4 X 6 7 X 9])).to eq(true)
        expect(game.game_over?(%w[O O X 4 5 X 7 8 X])).to eq(true)
        expect(game.game_over?(%w[X O O 4 X 6 7 8 X])).to eq(true)
        expect(game.game_over?(%w[O O X 4 X 8 X 8 9])).to eq(true)
      end
    end

    context "game not over" do
      it 'should return a false boolean value' do
        expect(game.game_over?(%w[1 2 3 4 5 6 7 8 9])).to eq(false)
        expect(game.game_over?(%w[X O X O 5 6 7 8 9])).to eq(false)
        expect(game.game_over?(%w[1 X O X O X X O X])).to eq(false)
      end
    end
  end

  describe "#game_status" do 
    context 'board not full and no winning board' do 
      it 'should return an keep playing message' do 
        expect(game.game_status(%w[X O X O 5 6 7 8 9])).to eq('Keep playing')
      end
    end

    context 'board full and no winning board' do 
      it 'should return an tie message' do 
        expect(game.game_status(%w[X X O O X X X O O])).to eq('Tie')
      end
    end

    context 'board full and winning board' do 
      it 'should return an won message' do 
        expect(game.game_status(%w[X X X O O O 7 8 9])).to eq('Won')
      end
    end
  end

  describe "#winning_player" do 
    context 'if X wins a game' do 
      it 'should return X marker' do
        expect(game.winning_player(%w[X X X O 5 6 O 8 9], player1, player2)).to eq('X') 
      end
    end

    context 'if O wins a game' do 
      it 'should return O marker' do 
        expect(game.winning_player(%w[O O O X 5 6 X 8 9], player1, player2)).to eq('O')
      end
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