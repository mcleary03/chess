require_relative 'board.rb'
require_relative 'display.rb'

class Game
  attr_reader :board, :display
  def initialize
    @board = Board.new
    @display = Display.new(@board)
  end
end

if __FILE__ == $PROGRAM_NAME
  chess = Game.new
  loop do
    chess.display.render
    chess.display.cursor.get_input
    system("clear")
  end

end
