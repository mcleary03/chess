module SteppingPiece
  def moves
    possible_moves = []
    move_diffs.each do |diff|
    end_pos = [@current_pos[0] + diff[0], @current_pos[1] + diff[1]]
      if @board.in_bounds?(diff, @current_pos) && @board[end_pos].color != @color
        possible_moves << end_pos
      end
    end
    possible_moves
  end

  private
  def move_diffs
    
  end

end
