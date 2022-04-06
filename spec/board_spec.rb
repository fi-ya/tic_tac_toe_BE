require 'board'

RSpec.describe Board do
  subject(:board) { described_class.new(%w[1 2 3 4 5 6 7 8 9]) }

  describe '#mark_board' do
    it 'should mark the board correctly' do
      grid = %w[1 2 3 4 5 6 7 8 9]
      player = 'X'
      move = 1
      expect(board.mark_board(grid, player, move)).to eq(%w[X 2 3 4 5 6 7 8 9])
    end
  end

  describe '#available_moves' do
    it 'should return an array of 7 avaialble moves when given a grid with two positions taken' do
      expect(board.available_moves(%w[X O 3 4 5 6 7 8 9])).to eq(%w[3 4 5 6 7 8 9])
    end
  end

  describe '#board_full' do
    context 'when the board is full' do
      it 'should return a true boolean value' do
        expect(board.board_full?(%w[X O X O X O X O X])).to eq(true)
      end
    end

    context 'when the board is not full' do
      it 'should return a false boolean value' do
        expect(board.board_full?(%w[1 2 3 4 5 6 7 8 9])).to eq(false)
        expect(board.board_full?(%w[X O X O 5 6 7 8 9])).to eq(false)
        expect(board.board_full?(%w[X O X O X O X O 9])).to eq(false)
      end
    end
  end

  describe '#position_taken?' do
    it 'should return a true boolean value if the position is taken' do
      expect(board.position_taken?(1, %w[X O X O X O X O 9])).to eq(true)
      expect(board.position_taken?(2, %w[X O X O X O X O 9])).to eq(true)
      expect(board.position_taken?(4, %w[X O X O X O X O 9])).to eq(true)
    end

    it 'should return a false boolean value if the position is not taken' do
      expect(board.position_taken?(7, %w[X O X O X O 7 8 9])).to eq(false)
      expect(board.position_taken?(8, %w[X O X O X O 7 8 9])).to eq(false)
      expect(board.position_taken?(9, %w[X O X O X O 7 8 9])).to eq(false)
    end
  end

  describe '#win?' do
    it 'should return a true boolean value if there is a winning grid' do
      expect(board.win?(%w[X X X O O 6 7 8 9])).to eq(true)
      expect(board.win?(%w[1 2 3 X X X 7 O O])).to eq(true)
      expect(board.win?(%w[1 2 3 O O 6 X X X])).to eq(true)
      expect(board.win?(%w[X 2 3 X O O X 8 9])).to eq(true)
      expect(board.win?(%w[O X O 4 X 6 7 X 9])).to eq(true)
      expect(board.win?(%w[O O X 4 5 X 7 8 X])).to eq(true)
      expect(board.win?(%w[X O O 4 X 6 7 8 X])).to eq(true)
      expect(board.win?(%w[O O X 4 X 8 X 8 9])).to eq(true)
    end

    it 'should return a false boolean value if there is not a winning grid' do
      expect(board.win?(%w[X X O O X X X O O])).to eq(false)
      expect(board.win?(%w[X O X O X X O X O])).to eq(false)
    end
  end

  describe '#reset_grid' do
    it 'should return a new grid' do
      grid = %w[X X X O O 6 7 8 9]
      expect(board.reset_grid).to eq(%w[1 2 3 4 5 6 7 8 9])
    end
  end
end
