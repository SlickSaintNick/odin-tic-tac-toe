# frozen_string_literal: true

# Takes turns making moves in the game.
class Player
  attr_reader :name
  attr_accessor :my_turn, :x_or_o

  def initialize(name, my_turn, x_or_o)
    @name = name
    @my_turn = my_turn
    @x_or_o = x_or_o
  end

  def take_turn(board)
    keep_going = true
    while keep_going
      print "#{@name} >> "
      move = gets.chomp.downcase.strip.slice(0..1)
      if !move.match(/[a-c][1-3]/)
        puts 'Type the column letter followed by the row number, e.g. >> a3'
      elsif !board.valid_move?(move)
        puts 'Invalid move - that square is already taken!'
      else
        board.update(move, @x_or_o)
        keep_going = false
      end
    end
  end
end
