require 'byebug'
require 'colorize'
require_relative 'cursor'
class Display
  attr_reader :cursor
  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def render
    symb = :white
    @board.grid.each_with_index do |row, idx1|
      printable_row = ""

      row.each_with_index do |square, idx2|
        if [idx1, idx2] == @cursor.cursor_pos
          if @cursor.selected
            printable_row += (" " + square.symbol.to_s + " ").colorize(:background => :light_cyan)
          else
            printable_row += (" " + square.symbol.to_s + " ").colorize(:background => :light_yellow)
          end
          #printable_row += " ".colorize(:background => symb)
        else
          printable_row += " #{square.symbol} ".colorize(:background => symb)
        end
        symb = symb == :white ? :default : :white
      end
      symb = symb == :white ? :default : :white
      puts printable_row
    end
  end

end
