class Board
  
  WINNING_MOVES = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ].freeze

  def mark_board(grid, player, move)
    grid[move - 1] = player
    grid
  end

  def available_moves(grid)
    available_moves = []
    grid.each do |cell|
      available_moves.push(cell) if cell.count('1-9').positive?
    end
    available_moves
  end

  def board_full?(grid)
    available_moves(grid).empty?
  end

  def position_taken?(position, grid)
    !grid.include?(position.to_s)
  end

  def win?(grid)
    winning_plays = []

    WINNING_MOVES.all? do |winning_game|
      pos1_eq_pos2 = grid[winning_game[0]] == grid[winning_game[1]]
      pos2_eq_po3 = grid[winning_game[1]] == grid[winning_game[2]]
      winning_plays.push(pos1_eq_pos2 && pos2_eq_po3 ? true : false)
    end

    winning_plays.any? { |game| game == true }
  end

  def reset_grid
    %w[1 2 3 4 5 6 7 8 9]
  end
end
