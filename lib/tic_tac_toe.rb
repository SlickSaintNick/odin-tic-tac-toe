# frozen_string_literal: true

require_relative 'game_board'
require_relative 'score_board'
require_relative 'player'

def introduce_game
  Gem.win_platform? ? (system 'cls') : (system 'clear')
  puts "
  _____ ___ ____    _____  _    ____    _____ ___  _____
 |_   _|_ _/ ___|  |_   _|/ \\  / ___|  |_   _/ _ \\| ____|
   | |  | | |   _____| | / _ \\| |   _____| || | | |  _|
   | |  | | |__|_____| |/ ___ \\ |__|_____| || |_| | |___
   |_| |___\\____|    |_/_/   \\_\\____|    |_| \\___/|_____|

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

introduce_game()

player1 = Player.new(ask_name(1), true, 'X')
player2 = Player.new(ask_name(2), false, 'O')

ScoreBoard.display(player1, player2)
GameBoard.display

keep_going = true
while keep_going do
  if player1.my_turn
    player1.take_turn(GameBoard)
    player1.my_turn = false
    player2.my_turn = true
  elsif player2.my_turn
    player2.take_turn(GameBoard)
    player2.my_turn = false
    player1.my_turn = true
  end
  ScoreBoard.display(player1, player2)
  GameBoard.display
  winner = GameBoard.game_over
  next if winner == 'none'

  keep_going = ScoreBoard.update(winner, player1, player2)
  GameBoard.clear
  ScoreBoard.display(player1, player2)
  GameBoard.display
end
ScoreBoard.final_result(player1, player2)
