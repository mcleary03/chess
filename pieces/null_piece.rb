require 'singleton'
require_relative 'piece.rb'

class NullPiece < Piece
  include Singleton

  attr_reader :color, :symbol

  def initialize
    @symbol = " "
    @color = :blue
  end
end
