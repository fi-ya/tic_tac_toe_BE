require 'board'

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#reset_grid' do
    it 'should return a new grid' do
      expect(board.reset_grid).to eq([:empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty])
    end
  end

  describe '#convert_sqaures_to_JSON' do
    it 'should return a new grid with empty strings' do
      grid = [:empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty]
      expect(board.convert_sqaures_to_JSON(grid)).to eq([" ", " ", " ", " ", " ", " ", " ", " ", " "])
    end

    it 'should return a new grid with empty strings and players markers' do
      grid = [:X, :O, :X, :empty, :empty, :empty, :empty, :empty, :empty]
      expect(board.convert_sqaures_to_JSON(grid)).to eq(["X", "O", "X", " ", " ", " ", " ", " ", " "])
    end
  end

  describe '#convert_square_with_state' do
    it 'should return a empty symbol' do
      empty_square = " "
      expect(board.convert_square_with_state(empty_square)).to eq(:empty)
    end

    it 'should return a player1_mark symbol' do
      player1_square = "X"
      expect(board.convert_square_with_state(player1_square)).to eq(:X)
    end

    it 'should return a player2_mark symbol' do
      player2_square = "O"
      expect(board.convert_square_with_state(player2_square)).to eq(:O)
    end
  end

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

end
