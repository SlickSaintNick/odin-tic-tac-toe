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
    it 'sends a message "display" to score_board with the two player objects' do
      score_board = game.instance_variable_get(:@score_board)
      player1 = game.instance_variable_get(:@player1)
      player2 = game.instance_variable_get(:@player2)

      # Suppress puts
      allow($stdout).to receive(:puts)
      allow(score_board).to receive(:clear_screen).and_return nil
      ENV['RSPEC_TEST'] = 'true'

      expect(score_board).to receive(:display).with(player1, player2)
      game.display_board

      ENV['RSPEC_TEST'] = nil
    end

    it 'sends a message "display" to game_board' do
      game_board = game.instance_variable_get(:@game_board)
      allow($stdout).to receive(:puts)
      expect(game_board).to receive(:display)
      game.display_board
    end
  end

  # subject(:game) { described_class.new }
  # let(:player1) { Player.new('player1', true, 'X') }
  # let(:player2) { Player.new('player2', false, 'O') }

  # before do
  #   game.instance_variable_set(:@player1, player1)
  #   game.instance_variable_set(:@player2, player2)
  #   allow(player1).to receive(player1.take_turn).and_return nil
  # end

  # describe '#player_turn' do
  #   it 'calls player1.take_turn when it is player1 turn' do
  #     expect(player1).to receive(player1.take_turn)

  #   end

  # end

end
