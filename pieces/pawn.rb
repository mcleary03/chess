require_relative 'piece.rb'

class Pawn < Piece

  def initialize(current_pos, color, symbol, forward_dir, board)
    @forward_dir = forward_dir
    @initial_pos = current_pos.dup
    super(current_pos, color, symbol, board)
  end

  def moves
    forward_steps.map{ |diff| [@current_pos[0] + diff[0], @current_pos[1] + diff[1]] } +
    side_attacks.map{ |diff| [@current_pos[0] + diff[0], @current_pos[1] + diff[1]] }
  end

  #protected
  def at_start_row?
    @current_pos == @initial_pos
  end

  def forward_steps
    if at_start_row?
      if forward_dir == :down
        [[-1, 0], [-2, 0]]
      else
        [[1, 0], [2, 0]]
      end
    else
      if forward_dir == :down
        [-1, 0]
      else
        [1, 0]
      end
    end
  end

  def side_attacks
    if forward_dir == :down
      [[-1, -1], [-1, 1]]
    else
      [[1, -1], [1, 1]]
    end
  end
end
