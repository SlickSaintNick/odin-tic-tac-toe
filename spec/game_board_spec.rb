# frozen_string_literal: true

require_relative '../lib/game_board'

describe GameBoard do
  subject(:game_board) { described_class.new }
  let(:initial_board) { [
    'X', 'O', 'X',
    ' ', ' ', ' ',
    ' ', ' ', ' '
  ] }

  before do
    game_board.instance_variable_set(:@state, initial_board)
  end

  describe '#update' do
    it 'updates a square on the board' do
      move = 'a1'
      x_or_o = 'O'
      expect { game_board.update(move, x_or_o) }.to(change { game_board.instance_variable_get(:@state)[6] })
    end

    it 'updates the expected square on the board' do
      move = 'a1'
      x_or_o = 'O'
      expect { game_board.update(move, x_or_o) }
        .to change { game_board.instance_variable_get(:@state)[6] }
        .from(' ').to(x_or_o)
    end
  end

  describe '#square_available?' do
    it 'returns true for a vacant square' do
      valid_move = 'a2'
      expect(game_board.square_available?(valid_move)).to be true
    end

    it 'returns false if the square is taken' do
      invalid_move = 'a3'
      expect(game_board.square_available?(invalid_move)).to be false
    end
  end

  describe '#check_win_conditions' do
    it 'returns "none" if the position is not won' do
      expect(game_board.check_win_conditions).to eql('none')
    end

    it 'returns "tie" if the position is not won and all squares are taken' do
      game_board.instance_variable_set(:@state, [
        'X', 'O', 'X',
        'O', 'X', 'O',
        'O', 'X', 'O'
      ])
      expect(game_board.check_win_conditions).to eql('tie')
    end

    it 'returns "X" if X wins with a horizontal line win condition' do
      game_board.instance_variable_set(:@state, [
        'X', 'X', 'X',
        'O', 'O', ' ',
        ' ', ' ', ' '
      ])
      expect(game_board.check_win_conditions).to eql('X')
    end
    it 'returns "O" if O wins with a vertical line win condition' do
      game_board.instance_variable_set(:@state, [
        'O', ' ', ' ',
        'O', 'X', ' ',
        'O', 'X', ' '
      ])
      expect(game_board.check_win_conditions).to eql('O')
    end

    it 'returns "X" if X wins with a diagonal line win condition' do
      game_board.instance_variable_set(:@state, [
        'O', 'X', 'X',
        'O', 'X', 'O',
        'X', 'O', ' '
      ])
      expect(game_board.check_win_conditions).to eql('X')
    end

    it 'returns "O" if O wins when all squares are full' do
      game_board.instance_variable_set(:@state, [
        'O', 'O', 'O',
        'X', 'X', 'O',
        'X', 'O', 'X'
      ])
      expect(game_board.check_win_conditions).to eql('O')
    end
  end

  describe '#clear' do
    it 'resets the game state' do
      expect { game_board.clear }
        .to change { game_board.instance_variable_get(:@state) }
        .from(initial_board).to([' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '])
    end
  end
end
