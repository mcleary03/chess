require_relative '../modules/sliding_piece'
require_relative 'piece.rb'

class Rook < Piece
  include SlidingPiece

  def initialize(current_pos, color, symbol, board)
    super
  end

  #protected
  def move_dirs
    horizontal_dirs
  end
end
