require_relative '../modules/stepping_piece.rb'
require_relative 'piece.rb'

class King < Piece
  include SteppingPiece

  def initialize(current_pos, color, symbol, board)
    super
  end

  #protected
  def move_diffs
    [
     [0, 1],
     [0, -1],
     [1, 0],
     [-1, 0],
     [1, 1],
     [1, -1],
     [-1, 1],
     [-1, -1]
   ]
  end
end
