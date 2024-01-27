# frozen_string_literal: true

# Keeps track of score and checks for a winner.
class ScoreBoard
  def initialize
    @player1_score = 0
    @player2_score = 0
    @tie = 0
  end

  def update_score(winner, player1, player2)
    case winner
    when 'tie'
      @tie += 1
    when player1.x_or_o
      @player1_score += 1
    when player2.x_or_o
      @player2_score += 1
    end
  end

  def display_round_winner(winner, player1, player2)
    case winner
    when 'tie'
      puts "\nThat round was a tie!"
    when player1.x_or_o
      puts "\n#{player1.name} won that round!"
    when player2.x_or_o
      puts "\n#{player2.name} won that round!"
    end
  end

  def display(player1, player2)
    clear_screen
    puts '-------------------'
    puts "Player 1 - #{player1.x_or_o}    #{@player1_score}"
    puts "#{player1.my_turn ? '>> ' : '   '}#{player1.name}#{player1.my_turn ? ' <<' : ''}"
    puts "\nPlayer 2 - #{player2.x_or_o}    #{@player2_score}"
    puts "#{player2.my_turn ? '>> ' : '   '}#{player2.name}#{player2.my_turn ? ' <<' : ''}"
    puts "\nTied games      #{@tie}"
    puts '-------------------'
  end

  def clear_screen
    Gem.win_platform? ? system('cls') : system('clear')
  end

  def display_final_result(player1_name, player2_name)
    puts "\nGame over!\n"
    puts 'The final results were:'
    puts "#{@player1_score}\t - \t#{player1_name}"
    puts "#{@player2_score}\t - \t#{player2_name}"
    puts "#{@tie}\t - \tTied rounds\n\n\n"
  end
end
