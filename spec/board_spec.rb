require 'board'

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#mark_board' do
    it 'should mark the board correctly' do
      grid = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      player = 'X'
      move = [:empty, 0]
      expect(board.mark_board(grid, player, move)).to eq([:X, " ", " ", " ", " ", " ", " ", " ", " "])
    end
  end

  describe '#available_moves' do
    it 'should return an array of 7 avaialble moves when given a grid with two positions taken' do
      expect(board.available_moves([:X, :O, :empty, :empty, :empty, :empty, :empty, :empty, :empty])).to eq([[:empty, 2], [:empty, 3], [:empty, 4], [:empty, 5], [:empty, 6], [:empty, 7], [:empty, 8]])
    end
  end

  describe '#board_full' do
    context 'when the board is full' do
      it 'should return a true boolean value' do
        expect(board.board_full?([:X, :O, :X, :O, :X, :X, :O, :X, :O])).to eq(true)
      end
    end

    context 'when the board is not full' do
      it 'should return a false boolean value' do
        expect(board.board_full?([:empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty])).to eq(false)
        expect(board.board_full?([:X, :O, :empty, :empty, :empty, :empty, :empty, :empty, :empty])).to eq(false)
        expect(board.board_full?([:X, :O, :X, :O, :X, :X, :O, :empty, :O])).to eq(false)
      end
    end
  end

  describe '#win?' do
    it 'should return a true boolean value if there is a winning grid' do
      expect(board.win?([:X, :X, :X, :O, :O, :empty, :empty, :empty, :empty])).to eq(true)
      expect(board.win?([:empty, :empty, :empty, :X, :X, :X, :empty, :O, :O])).to eq(true)
      expect(board.win?([:X, :X, :X, :O, :O, :empty, :X, :X, :X])).to eq(true)
      expect(board.win?([:X, :empty, :empty, :X, :O, :O, :X, :empty, :empty])).to eq(true)
      # expect(board.win?(%w[O X O 4 X 6 7 X 9])).to eq(true)
      # expect(board.win?(%w[O O X 4 5 X 7 8 X])).to eq(true)
      # expect(board.win?(%w[X O O 4 X 6 7 8 X])).to eq(true)
      # expect(board.win?(%w[O O X 4 X 8 X 8 9])).to eq(true)
    end

    it 'should return a false boolean value if there is not a winning grid' do
      expect(board.win?([:X, :X, :O, :O, :X, :X, :X, :O, :O])).to eq(false)
      expect(board.win?([:X, :X, :O, :O, :X, :X, :X, :O, :O])).to eq(false)
    end
  end

  describe '#reset_grid' do
    it 'should return a new grid' do
      expect(board.reset_grid).to eq([:empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty])
    end
  end
end
