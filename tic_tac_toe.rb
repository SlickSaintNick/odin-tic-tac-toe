class ScoreBoard
  def initialize
    @player1 = 0
    @player2 = 0
    @tie = 0
  end

  def score_round(winner)
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
end

class GameBoard
  attr_accessor :game_board

  def initialize
    @state = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
    @move_index = ['a3', 'b3', 'c3', 'a2', 'b2', 'c2', 'a1', 'b1', 'c1']
    @grid = '    +---+---+---+'
    @bottom_line = "      a   b   c\n"
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
    @state[@move_index.find_index(move)] == ' ' ? true : false
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
      if !(move.match(/[a-c][1-3]/))
        puts 'Type the column letter followed by the row number, e.g. >> a3'
      elsif !(board.valid_move?(move))
        puts 'Invalid move - that square is already taken!'
      else
        board.update(move, @x_or_o)
        keep_going = false
      end
    end
  end
end

class Referee
  def introduce_game
  end

  def ask_name(number)
    print "Player #{number} name? >> "
    gets.chomp
  end

  def game_over
  end

  def announce_result
  end
end

score = ScoreBoard.new
board = GameBoard.new
referee = Referee.new
# referee.introduce_game

player1 = Player.new(referee.ask_name(1), true, 'X')
player2 = Player.new(referee.ask_name(2), false, 'O')

keep_going = true
while keep_going do
  score.display(player1, player2)
  board.display
  if player1.my_turn
    player1.take_turn(board)
    player1.my_turn = false
    player2.my_turn = true
  elsif player2.my_turn
    player2.take_turn(board)
    player2.my_turn = false
    player1.my_turn = true
  end
end
#   if referee.game_over
#     referee.announce_result
#     score_board.score_round
#     keep_going = referee.play_again? ? true | false
#   end
# end
