require 'board'

RSpec.describe Board do 

  context "#mark_board" do 
    it 'should mark the board correctly' do 
      grid = %w[1 2 3 4 5 6 7 8 9]
      player = 'X'
      move = 1
      board = Board.new(grid)

      expect(board.mark_board(grid, player, move)).to eq(%w[X 2 3 4 5 6 7 8 9])
    end 
  end

  context "#available_moves" do 
    it 'should return an array of 7 avaialble moves when given a grid with two positions taken' do 
      grid = %w[X O 3 4 5 6 7 8 9]
      board = Board.new(grid)
    
      expect(board.available_moves(grid)).to eq(%w[3 4 5 6 7 8 9])
    end
  end

  context "#board_full" do 
    it 'should return a true boolean value when the grid is full' do 
      grid = %w[X O X O X O X O X]
      board = Board.new(grid)
    
      expect(board.board_full?(grid)).to eq(true)
    end
    it 'should return a false boolean value when the grid is not full' do 
      grid = %w[X O X O X O X O 9]
      board = Board.new(grid)
    
      expect(board.board_full?(grid)).to eq(false)
    end
  end

  context "#position_taken?" do 
    it 'should return a true boolean value if the position is taken' do 
      grid = %w[X O X O X O X O 9]
      board = Board.new(grid)
      position = 1
    
      expect(board.position_taken?(position, grid)).to eq(true)
    end

    it 'should return a false boolean value if the position is not taken' do 
      grid = %w[X O X O X O X O 9]
      board = Board.new(grid)
      position = 9
    
      expect(board.position_taken?(position, grid)).to eq(false)
    end
  end

  context "#win?" do 
    it 'should return a true boolean value if there is a winning grid' do 
      grid = %w[X X X O O 6 7 8 9]
      board = Board.new(grid)

      expect(board.win?(grid)).to eq(true)
    end

    it 'should return a false boolean value if there is not a winning grid' do 
      grid = %w[X X O X O 6 7 8 9]
      board = Board.new(grid)

      expect(board.win?(grid)).to eq(false)
    end
  end

  context "#reset_grid" do 
    it 'should return a new grid' do 
      grid = %w[X X X O O 6 7 8 9]
      board = Board.new(grid)

      expect(board.reset_grid).to eq(%w[1 2 3 4 5 6 7 8 9])
    end
  end
end