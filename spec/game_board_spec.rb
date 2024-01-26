# frozen_string_literal: true

require_relative '../lib/game_board'

describe GameBoard do
  subject(:game_board) { described_class.new }

  describe '.update' do
    it 'allows a valid move' do
      game_board.instance_variable_set(:@state, ['X', 'O', 'X', ' ', ' ', ' ', ' ', ' ', ' '])
      valid_move = 'a2'
      expect(game_board.update(valid_move, 'O')).to
    end
  end

  # .display
  # This method prints the game
end
