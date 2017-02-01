require_relative '../modules/sliding_piece'
require_relative 'piece'

class Queen < Piece
  include SlidingPiece

  def initialize(current_pos, color, symbol, board)
    super
  end

  #protected
  def move_dirs
    horizontal_dirs + diagonal_dirs
  end
end
