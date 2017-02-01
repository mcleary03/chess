require_relative '../modules/stepping_piece.rb'
require_relative 'piece.rb'

class Knight < Piece
  include SteppingPiece

  def initialize(current_pos, color, symbol, board)
    super
  end

  #protected
  def move_diffs
    [
      [-2, -1],
      [-2,  1],
      [-1, -2],
      [-1,  2],
      [ 1, -2],
      [ 1,  2],
      [ 2, -1],
      [ 2,  1]
    ]
  end
end
