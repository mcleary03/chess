# require_relative 'pieces/piece.rb'
# require_relative 'null_piece.rb'
Dir[File.dirname(__FILE__) + '/pieces/*.rb'].each {|file| require file }
#require 'byebug'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    @null_piece =  NullPiece.instance
    make_starting_grid

  end

  def make_starting_grid
    layout = [
    Rook.new([0, 0], :white, "\u2656", self),
    Knight.new([0, 1], :white, "\u2658", self),
    Bishop.new([0, 2], :white, "\u2657", self),
    Queen.new([0, 3], :white, "\u2655", self),
    King.new([0, 4], :white, "\u2654", self),
    Bishop.new([0, 5], :white, "\u2657", self),
    Knight.new([0, 6], :white, "\u2658", self),
    Rook.new([0, 7], :white, "\u2656", self),
    Rook.new([7, 0], :black, "\u265C", self),
    Knight.new([7, 1], :black, "\u265E", self),
    Bishop.new([7, 2], :black, "\u265D", self),
    Queen.new([7, 3], :black, "\u265B", self),
    King.new([7, 4], :black, "\u265A", self),
    Bishop.new([7, 5], :black, "\u265D", self),
    Knight.new([7, 6], :black, "\u265E", self),
    Rook.new([7, 7], :black, "\u265C", self)
    ]
    [0,7].each do |idx|
      (0..7).each do |idx2|
        @grid[idx][idx2] = layout.shift
      end
    end

    forward_dir = :up
    [1,6].each do |idx|
      symb, pawn_color = :white, "\u2659"
      symb, pawn_color = :black, "\u265F" if idx == 6
      (0..7).each do |idx2|
        @grid[idx][idx2] = Pawn.new([idx, idx2], symb, pawn_color, forward_dir, self)
      end
      forward_dir = :down
    end

    (2..5).each do |idx|
      (0..7).each do |idx2|
        @grid[idx][idx2] = @null_piece
      end
    end

    @grid
  end

  def in_bounds?(diff, cursor_pos)
    x = cursor_pos[0] + diff[0]
    y = cursor_pos[1] + diff[1]

    x.between?(0,7) && y.between?(0,7)
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def deep_dup
    temp = Marshal.dump(board)
    Marshal.load(temp)
  end

  def locate_king(color)
    @grid.each_with_index do |row, idx1|
      row.each_with_index do |piece, idx2|
        king_pos = [idx1, idx2] if (piece.symbol == "\u2654" ||
         piece.symbol == "\u265A") && piece.color == current_color
      end
    end
    king_pos
  end

  def in_check?(current_color)
    king_pos = locate_king(color)

    enemy_pieces = @grid.select { |piece| piece.color != current_color && !piece.is_a?(NullPiece) }

    enemy_pieces.any? { |piece| piece.moves.include?(king_pos)}
  end

  def checkmate?(color)
    return false unless in_check?(color)

    king_pos = locate_king(color)

    #can the king can be moved out of check?
    self[[king_pos]].moves.each do |move|
      new_board = self.deep_dup

      new_board[king_pos], new_board[move]  = @null_piece, new_board[king_pos]
      return false unless in_check?(color)
    end

    #can the attacking enemy be eliminated?
    friendly_pieces = @grid.select { |piece| piece.color == current_color }

    enemy_pieces = @grid.select { |piece| piece.color != current_color && !piece.is_a?(NullPiece) }
    danger = enemy_pieces.select { |enemy| enemy.moves.include?(king_pos) }

    return false if friendly_pieces.any? { |friend| friend.moves.include?(danger.current_pos) }

    #can we sacrifice a piece to save the king? Long live the king
    danger_path = danger.moves.select { |move| move.include?(king_pos)}

    return false if friendly_pieces.any? do |friend|
      friend.moves.any? do |f_move|
        danger_path.include?(f_move)
      end
    end

    #return true if the king is doomed
    true
  end
end
