# frozen_string_literal: true

# Keeps track of the state of the board and displays the board
class GameBoard
  @state = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  @MOVE_INDEX = ['a3', 'b3', 'c3', 'a2', 'b2', 'c2', 'a1', 'b1', 'c1']
  @GRID = '    +---+---+---+'
  @BOTTOM_LINE = "      a   b   c\n"
  @WIN_CONDITIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  def self.display
    [3, 2, 1].each do |i|
      first_index = (3 - i) * 3

      puts @GRID
      print_row(
        i,
        @state[first_index],
        @state[first_index + 1],
        @state[first_index + 2]
      )
    end
    puts @GRID
    puts @BOTTOM_LINE
  end

  def self.print_row(row_number, a, b, c)
    puts "  #{row_number} | #{a} | #{b} | #{c} |"
  end

  def self.update(move, x_or_o)
    @state[@MOVE_INDEX.find_index(move)] = x_or_o
  end

  def self.valid_move?(move)
    @state[@MOVE_INDEX.find_index(move)] == ' '
  end

  def self.game_over
    @WIN_CONDITIONS.each do |arr|
      line = [@state[arr[0]], @state[arr[1]], @state[arr[2]]]
      return 'X' if line.all? { |str| str == 'X' }
      return 'O' if line.all? { |str| str == 'O' }
    end
    return 'tie' if !@state.include?(' ')
    'none'
  end

  def self.clear
    @state = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  end
end
