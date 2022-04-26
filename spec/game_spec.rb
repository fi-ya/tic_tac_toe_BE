require 'game'
require 'board'
require 'human_player'
require 'computer_player'

RSpec.describe Game do
  let(:board) { Board.new }
  let(:player1) { HumanPlayer.new('X', 'Human') }
  let(:player2) { HumanPlayer.new('O', 'Human') }
  let(:current_player) { :player1 }
  subject(:game) { described_class.new(board, player1, player2) }

  describe '#play_turn' do
    it 'should return an error message if invalid move' do
      expect(game.play_turn(%w[X O 3 4 5 6 7 8 9], 'X', 2, player1, player2)).to eq('Invalid move. Try again')
    end
  end

  describe '#update_board' do
    it 'should update the board with the correct marker' do
      expect(game.update_board(%w[1 2 3 4 5 6 7 8 9], 'X', 1, player1, player2)).to eq(%w[X 2 3 4 5 6 7 8 9])
    end
  end

  describe '#update_current_player' do
    context 'human vs human game' do
      it 'should update current player correctly' do
        expect(game.update_current_player('X', player1, player2)).to be_instance_of(HumanPlayer)
        expect(game.update_current_player('O', player1, player2)).to be_instance_of(HumanPlayer)
      end
    end

    context 'computer vs human game' do
      let(:player1) { ComputerPlayer.new('X', 'Computer') }
      let(:player2) { HumanPlayer.new('O', 'Human') }
      it 'should update current player correctly' do
        expect(game.update_current_player('X', player1, player2)).to be_instance_of(HumanPlayer)
        expect(game.update_current_player('O', player1, player2)).to be_instance_of(ComputerPlayer)
      end
    end
  end

  describe '#game_over?' do
    context 'game over' do
      it 'game is over' do
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

    context 'game not over' do
      it 'game is not over' do
        expect(game.game_over?(%w[1 2 3 4 5 6 7 8 9])).to eq(false)
        expect(game.game_over?(%w[X O X O 5 6 7 8 9])).to eq(false)
        expect(game.game_over?(%w[1 X O X O X X O X])).to eq(false)
      end
    end
  end

  describe '#game_status' do
    it 'should return an keep playing message when board not full and no winning board' do
      expect(game.game_status(%w[X O X O 5 6 7 8 9])).to eq('Keep playing')
    end

    it 'should return an tie message when board full and no winning board' do
      expect(game.game_status(%w[X X O O X X X O O])).to eq('Tie')
    end

    it 'should return an won message when board full and winning board' do
      expect(game.game_status(%w[X X X O O O 7 8 9])).to eq('Won')
    end
  end

  describe '#winning_player' do
    it 'should return X marker if X wins a game' do
      expect(game.winning_player(%w[X X X O 5 6 O 8 9], player1, player2)).to eq('X')
    end

    it 'should return O marker if O wins a game' do
      expect(game.winning_player(%w[O O O X 5 6 X 8 9], player1, player2)).to eq('O')
    end
  end

  describe '#valid_move?' do
    it 'should verify if move is not valid if player picks zero' do
      expect(game.valid_move?(0, %w[1 2 3 4 5 6 7 8 9])).to eq(false)
    end

    it 'should verify if move valid if player picks 6' do
      expect(game.valid_move?(6, %w[1 2 3 4 5 6 7 8 9])).to eq(true)
    end
  end
end
