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

  GRID_STATE = {empty: :empty , player1_mark: :X, player2_mark: :O}.freeze

  def reset_grid
    grid = [GRID_STATE[:empty], GRID_STATE[:empty],GRID_STATE[:empty],GRID_STATE[:empty], GRID_STATE[:empty],GRID_STATE[:empty],GRID_STATE[:empty],GRID_STATE[:empty],GRID_STATE[:empty]]
    grid  
  end

  def convert_sqaures_to_JSON(grid)
    grid.map do |square|
      if square === :empty
        " "
      elsif square === :X
        "X"
      else
        "O"
      end
    end
  end

  def convert_grid_with_state(grid_to_convert)
    grid_to_convert.map {|square| convert_square_with_state(square)}
  end

  def convert_square_with_state(square)
    if square === " "
      GRID_STATE[:empty]
    elsif square === "X"
      GRID_STATE[:player1_mark]
    else
      GRID_STATE[:player2_mark]
    end
  end

  def mark_board(grid, player, move)
    p "grid, player, move", grid, player, move
    grid[move[1]] = player.to_sym
    grid
  end

  def available_moves(grid)
    available_moves = []
    grid.each do |cell|
      if cell == :empty
        available_moves.push(cell) 
      end
    end
    available_moves
  end

  def board_full?(grid)
    p "board_full grid:", grid
    p "available moves in board full:", available_moves(grid).empty?
    available_moves(grid).empty?
  end

  # def position_taken?(position, grid)
  #   !grid.include?(position.to_s)
  # end

  def win?(grid)
    winning_plays = []

    WINNING_MOVES.all? do |winning_game|
      convert_empty_grid_to_num = []

      grid.map.with_index do |square, i| 
        if square === :empty
          convert_empty_grid_to_num.push(i)
        else
          convert_empty_grid_to_num.push(square)
        end
      end
      
      p "convert_empty_grid_to_num:", convert_empty_grid_to_num
      pos1_eq_pos2 = convert_empty_grid_to_num[winning_game[0]] == convert_empty_grid_to_num[winning_game[1]]
      pos2_eq_po3 = convert_empty_grid_to_num[winning_game[1]] == convert_empty_grid_to_num[winning_game[2]]
      winning_plays.push(pos1_eq_pos2 && pos2_eq_po3 ? true : false)
    end
    
    p "winning_plays:",  winning_plays
    p "winning_plays resylts:",  winning_plays.any? { |game| game == true }
    winning_plays.any? { |game| game == true }
  end

end