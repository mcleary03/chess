require 'byebug'

module SlidingPiece

  def moves
    #possible_moves = Hash.new { |h, k| h[k] = [] }
    possible_moves = []
    move_dirs.each do |dir|
      path = grow_unblocked_moves_in_dir(dir[0], dir[1])
      #end_pos = [@current_pos[0] + dir[0], @current_pos[1] + dir[1]]
      possible_moves << path unless path.empty?
    end
    possible_moves.flatten
  end

  #private
  def move_dirs

  end

  def horizontal_dirs
    [
      [1, 0],
      [0, 1],
      [-1, 0],
      [0, -1]
    ]
  end

  def diagonal_dirs
    [
      [1, 1],
      [1, -1],
      [-1, 1],
      [-1, -1]
    ]
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    path = []
    next_position = [@current_pos[0] + dx, @current_pos[1] + dy]
    position = @current_pos.dup
    #byebug
    while @board.in_bounds?([dx,dy], position) && @board[next_position].color != @color
      path << position
      break if @board[position].color != @color && !@board[position].is_a?(NullPiece)
      position = [position[0] + dx, position[1] + dy]
      next_position = [position[0] + dx, position[1] + dy]
    end
    path
  end
end
