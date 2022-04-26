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

  describe '#computer_move' do
    it 'should return first available :empty and its grid index' do
      grid = [:empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty]
      expect(game.computer_move(grid)).to eq([:empty, 0])
    end
  end
  
  describe '#play_turn' do
    it 'should return true if invalid move' do
      expect(game.play_turn(["X", "O", " ", " ", " ", " ", " ", " ", " "], 'X', ["X", "0"], player1, player2)).to eq(true)
    end
  end

  describe '#invalid_move?' do
    it 'should return true if player move invalid' do
      move = [:X, 0]
      expect(game.invalid_move?(move)).to eq(true)
    end

    it 'should return false if player valid' do
      move = [:empty, 0]
      expect(game.invalid_move?(move)).to eq(false)
    end
  end

  describe '#update_board' do
    it 'should update the board with the correct marker' do
      expect(game.update_board([:empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty], 'X', [:empty, 0], player1, player2)).to eq([:X, :empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty])
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
        expect(game.game_over?([:X, :X, :X, :O, :O, :empty, :empty, :empty, :empty])).to eq(true)
        expect(game.game_over?([:empty, :empty, :empty, :X, :X, :X, :empty, :O, :O])).to eq(true)
        expect(game.game_over?([:empty, :empty, :empty, :O, :O, :empty, :X, :X, :X])).to eq(true)
        expect(game.game_over?([:X, :empty, :empty, :X, :O, :O, :X, :empty, :empty])).to eq(true)
        expect(game.game_over?([:O, :X, :O, :empty, :X, :empty, :empty, :X, :empty])).to eq(true)
        expect(game.game_over?([:O, :O, :X, :empty, :empty, :X, :empty, :empty, :X])).to eq(true)
        expect(game.game_over?([:X, :O, :O, :empty, :X, :empty, :empty, :empty, :X])).to eq(true)
        expect(game.game_over?([:O, :O, :X, :empty, :X, :empty, :X, :empty, :empty])).to eq(true)
      end
    end

    context 'game not over' do
      it 'game is not over' do
        expect(game.game_over?([:empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty])).to eq(false)
        expect(game.game_over?([:X, :O, :X, :O, :empty, :empty, :empty, :empty, :empty])).to eq(false)
        expect(game.game_over?([:empty, :X, :O, :X, :O, :X, :X, :O, :X])).to eq(false)
      end
    end
  end

  describe '#game_status' do
    it 'should return an keep playing message when board not full and no winning board' do
      expect(game.game_status([:X, :O, :empty, :empty, :empty, :empty, :empty, :empty, :empty])).to eq('Keep playing')
    end

    it 'should return an tie message when board full and no winning board' do
      expect(game.game_status([:X, :X, :O, :O, :X, :X, :X, :O, :O])).to eq('Tie')
    end

    it 'should return an won message when board full and winning board' do
      expect(game.game_status([:X, :X, :X, :O, :O, :empty, :empty, :empty, :empty])).to eq('Won')
    end
  end

  describe '#winning_player' do
    it 'should return X marker if X wins a game' do
      expect(game.winning_player(["X", "X", "X", "O", "O", " ", " ", " ", " "], player1, player2)).to eq('X')
    end

    it 'should return O marker if O wins a game' do
      expect(game.winning_player(["X", "O", " ", "X", "O", "X", " ", "O", " "], player1, player2)).to eq('O')
    end
  end

  describe '#valid_move?' do
    it 'should verify if move is not valid if grid state is :O or :X' do
      expect(game.valid_move?([:O, 1])).to eq(false)
      expect(game.valid_move?([:X, 2])).to eq(false)
    end

    it 'should verify if move valid if grid state is empty' do
      expect(game.valid_move?([:empty, 1])).to eq(true)
    end
  end
end
