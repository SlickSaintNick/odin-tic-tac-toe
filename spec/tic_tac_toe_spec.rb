# frozen_string_literal: true

require_relative '../lib/tic_tac_toe'
require_relative '../lib/game_board'
require_relative '../lib/score_board'
require_relative '../lib/player'

describe TicTacToe do
  subject(:game) { described_class.new }

  it 'calls ask_name method during initialization' do
    allow_any_instance_of(described_class).to receive(:ask_name)
    test_game = described_class.new
    expect(test_game).to have_received(:ask_name).twice
  end

  it 'initializes instance variables' do
    allow_any_instance_of(described_class).to receive(:ask_name).and_return('player1', 'player2')
    test_game = described_class.new

    player1 = test_game.instance_variable_get(:@player1)
    expect(player1).to be_instance_of(Player)
    expect(player1.name).to eq('player1')
    expect(player1.my_turn).to be true
    expect(player1.x_or_o).to eql('X')

    player2 = test_game.instance_variable_get(:@player2)
    expect(player2).to be_instance_of(Player)
    expect(player2.name).to eq('player2')
    expect(player2.my_turn).to be false
    expect(player2.x_or_o).to eql('O')

    score_board = test_game.instance_variable_get(:@score_board)
    expect(score_board).to be_instance_of(ScoreBoard)

    game_board = test_game.instance_variable_get(:@game_board)
    expect(game_board).to be_instance_of(GameBoard)
  end

  describe '#display_board' do
    xit 'sends a message "display" to score_board with the two player objects' do
      player1 = double('Player1')
      player2 = double('Player2')
      score_board = double('ScoreBoard')
      game_board = double('GameBoard')

      # Suppress puts
      allow($stdout).to receive(:puts)
      allow(score_board).to receive(:clear_screen)
      allow(score_board).to receive(:display)

      expect(score_board).to receive(:display).with(player1, player2)

      display_game = TicTacToe.new
      allow(display_game).to receive(:instance_variable_get).and_return(:player1, :player2, :score_board, :game_board)

      display_game.display_board
    end

    xit 'sends a message "display" to game_board' do
      game_board = double('GameBoard')
      score_board = double('ScoreBoard')

      allow(game_board).to receive(:display).and_return nil
      allow(score_board).to receive(:display).and_return nil
      allow($stdout).to receive(:puts)

      display_game = TicTacToe.new
      allow(display_game).to receive(:instance_variable_get).and_return(game_board, score_board)

      expect(game_board).to receive(:display)
      game.display_board
    end
  end

  describe '#player_turn' do
    context 'when it is player1s turn' do
      it 'sends a message to player1 to take their turn'
      it 'does not send a message to player2 to take their turn'
      it 'updates player1.my_turn to false'
      it 'updates player2.my_turn to true'
    end
  end

end
