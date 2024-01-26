# frozen_string_literal: true

# Keeps track of score and checks for a winner.
class ScoreBoard
  @player1 = 0
  @player2 = 0
  @tie = 0

  def self.update(winner, player1, player2)
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

  def self.display(player1, player2)
    Gem.win_platform? ? (system 'cls') : (system 'clear')
    puts '-------------------'
    puts "Player 1 - #{player1.x_or_o}    #{@player1}"
    puts "#{player1.my_turn ? '>> ': '   '}#{player1.name}#{player1.my_turn ? ' <<' : ''}"
    puts "\nPlayer 2 - #{player2.x_or_o}    #{@player2}"
    puts "#{player2.my_turn ? '>> ': '   '}#{player2.name}#{player2.my_turn ? ' <<' : ''}"
    puts "\nTied games      #{@tie}"
    puts '-------------------'
  end

  def self.final_result(player1, player2)
    puts "\nGame over!\n"
    puts 'The final results were:'
    puts "#{@player1}\t - \t#{player1.name}"
    puts "#{@player2}\t - \t#{player2.name}"
    puts "#{@tie}\t - \tTied rounds\n\n\n"
  end
end
