class ScoreBoard
  def initialize
    @player1 = 0
    @player2 = 0
    @tie = 0
  end

  def update(winner, player1)
    if winner == 'tie'
      @tie += 1
      puts "\nThat round was a tie! Press 'Enter' to play another round, or 'exit' to quit."
    elsif winner == player1.x_or_o
      @player1 += 1
      puts "\n#{player1.name} won that round! Press 'Enter' to play another round, or 'exit' to quit."
    elsif winner == player2.x_or_o
      @player2 += 1
      puts "\n#{player2.name} won that round! Press 'Enter' to play another round, or 'exit' to quit."
    end

    if gets.chomp.downcase.strip.slice(0..3) == 'exit'
      return false
    else
      true
    end
  end

  def display(player1, player2)
    Gem.win_platform? ? (system 'cls') : (system 'clear')
    puts '-------------------'
    puts "Player 1 - #{player1.x_or_o}    #{@player1}"
    puts "#{player1.my_turn ? '>> ': '   '}#{player1.name}#{player1.my_turn ? ' <<' : ''}"
    puts "\nPlayer 2 - #{player2.x_or_o}    #{@player2}"
    puts "#{player2.my_turn ? '>> ': '   '}#{player2.name}#{player2.my_turn ? ' <<' : ''}"
    puts "\nTied games      #{@tie}"
    puts '-------------------'
  end

  def final_result(player1, player2)
    puts "\nGame over!\n"
    puts 'The final results were:'
    puts "#{@player1}\t - \t#{player1.name}"
    puts "#{@player2}\t - \t#{player2.name}"
    puts "#{@tie}\t - \tTied rounds\n\n\n"
  end
end

class GameBoard
  def initialize
    @state = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
    @move_index = ['a3', 'b3', 'c3', 'a2', 'b2', 'c2', 'a1', 'b1', 'c1']
    @grid = '    +---+---+---+'
    @bottom_line = "      a   b   c\n"
    @win_conditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]
  end

  def display
    [3, 2, 1].each do |i|
      first_index = (3 - i) * 3

      puts @grid
      print_row(
        i,
        @state[first_index],
        @state[first_index + 1],
        @state[first_index + 2]
      )
    end
    puts @grid
    puts @bottom_line
  end

  def print_row(row_number, a, b, c)
    puts "  #{row_number} | #{a} | #{b} | #{c} |"
  end

  def update(move, x_or_o)
    @state[@move_index.find_index(move)] = x_or_o
  end

  def valid_move?(move)
    @state[@move_index.find_index(move)] == ' '
  end

  def game_over
    return 'tie' if !@state.include?(' ')
    @win_conditions.each do |arr|
      line = [@state[arr[0]], @state[arr[1]], @state[arr[2]]]
      return 'X' if line.all? { |str| str == 'X' }
      return 'O' if line.all? { |str| str == 'O' }
    end
    'none'
  end

  def clear
    @state = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  end
end

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

def introduce_game
  Gem.win_platform? ? (system 'cls') : (system 'clear')
  puts "
  _____ ___ ____    _____  _    ____    _____ ___  _____
 |_   _|_ _/ ___|  |_   _|/ \  / ___|  |_   _/ _ \| ____|
   | |  | | |   _____| | / _ \| |   _____| || | | |  _|
   | |  | | |__|_____| |/ ___ \ |__|_____| || |_| | |___
   |_| |___\____|    |_/_/   \_\____|    |_| \___/|_____|

Play with 2 players.

Type in your moves using letters and numbers at the prompt.

E.g. to win this game - type in 'a2'.

      +---+---+---+
    3 | X | O | O |
      +---+---+---+
    2 |   | X |   |
      +---+---+---+
    1 | X |   | O |
      +---+---+---+
        a   b   c
  "
end

def ask_name(number)
  print "Player #{number} name? >> "
  gets.chomp
end

score = ScoreBoard.new
board = GameBoard.new
introduce_game()


player1 = Player.new(ask_name(1), true, 'X')
player2 = Player.new(ask_name(2), false, 'O')

score.display(player1, player2)
board.display

keep_going = true
while keep_going do
  if player1.my_turn
    player1.take_turn(board)
    player1.my_turn = false
    player2.my_turn = true
  elsif player2.my_turn
    player2.take_turn(board)
    player2.my_turn = false
    player1.my_turn = true
  end
  score.display(player1, player2)
  board.display
  winner = board.game_over
  next if winner == 'none'

  keep_going = score.update(winner, player1)
  board.clear
  score.display(player1, player2)
  board.display
end
score.final_result(player1, player2)
