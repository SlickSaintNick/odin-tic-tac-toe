# frozen_string_literal: true

# Keeps track of the state of the board and displays the board
class GameBoard
  def initialize
    @state = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
    @move_index = %w[a3 b3 c3 a2 b2 c2 a1 b1 c1]
    @grid = '    +---+---+---+'
    @bottom_line = "      a   b   c\n"
    @win_conditions = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7],
      [2, 5, 8], [0, 4, 8], [2, 4, 6]
    ]
  end

  def display
    [3, 2, 1].each do |i|
      first_index = (3 - i) * 3
      puts @grid
      print_row(i, @state[first_index], @state[first_index + 1], @state[first_index + 2])
    end
    puts @grid
    puts @bottom_line
  end

  def print_row(row_number, first_position, second_position, third_position)
    puts "  #{row_number} | #{first_position} | #{second_position} | #{third_position} |"
  end

  def update(move, x_or_o)
    @state[@move_index.find_index(move)] = x_or_o
  end

  def square_available?(move)
    @state[@move_index.find_index(move)] == ' '
  end

  def check_win_conditions
    @win_conditions.each do |arr|
      line = [@state[arr[0]], @state[arr[1]], @state[arr[2]]]
      return 'X' if line.all? { |str| str == 'X' }
      return 'O' if line.all? { |str| str == 'O' }
    end
    return 'tie' unless @state.include?(' ')

    'none'
  end

  def clear
    @state = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  end
end
