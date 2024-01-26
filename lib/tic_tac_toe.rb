# frozen_string_literal: true

require_relative 'game_board'
require_relative 'score_board'
require_relative 'player'

# 2-player Tic-Tac-Toe game
class TicTacToe
  def initialize
    @player1 = Player.new(ask_name('Player 1 name?'), true, 'X')
    @player2 = Player.new(ask_name('Player 2 name?'), false, 'O')
    @score_board = ScoreBoard.new
    @game_board = GameBoard.new
  end

  def play_game
    introduce_game
    display_board
    game_loop
    @score_board.display_final_result(@player1.name, @player2.name)
  end

  def game_loop
    loop do
      player_turn
      display_board
      winner = @game_board.check_win_conditions
      next if winner == 'none'

      @score_board.update_score(winner, @player1, @player2)
      display_round_winner(winner)
      return unless continue_playing?

      clear_board
    end
  end

  def player_turn
    if @player1.my_turn
      @player1.take_turn(@game_board)
      @player1.my_turn = false
      @player2.my_turn = true
    elsif @player2.my_turn
      @player2.take_turn(@game_board)
      @player2.my_turn = false
      @player1.my_turn = true
    end
  end

  def display_board
    @score_board.display(@player1, @player2)
    @game_board.display
  end

  def display_round_winner(winner)
    case winner
    when 'tie'
      puts "\nThat round was a tie!"
    when @player1.x_or_o
      puts "\n#{@player1.name} won that round!"
    when @player2.x_or_o
      puts "\n#{@player2.name} won that round!"
    end
  end

  def clear_board
    @game_board.clear
    display_board
  end

  def continue_playing?
    puts "Press 'Enter' to play another round, or 'exit' to quit."
    gets.chomp.downcase.strip.slice(0..3) != 'exit'
  end

  def ask_name(prompt)
    print "#{prompt} >> "
    gets.chomp
  end

  # rubocop:disable Metrics/MethodLength
  def introduce_game
    Gem.win_platform? ? (system 'cls') : (system 'clear')
    puts <<-INTRODUCTION
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
    INTRODUCTION
  end
  # rubocop:enable Metrics/MethodLength
end
