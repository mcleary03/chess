class Piece
  attr_reader :current_pos, :color, :symbol

  def initialize(current_pos, color, symbol, board)
    @current_pos = current_pos
    @color = color
    @symbol = symbol
    @board = board
  end

  def valid_moves
    valids = []
    possible_moves = self.moves

    possible_moves.each do |move|
      new_board = @board.deep_dup
      new_board[@current_pos], new_board[move]  = @null_piece, new_board[@current_pos]
      valids << move unless new_board.in_check?(@color)
    end
    valids
  end

  def move_into_check?(end_pos)

  end

  def to_s
    @symbol.to_s
  end

  def empty?
    self.is_a?(NullPiece)
  end
end
