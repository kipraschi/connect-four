require_relative '../lib/board'

RSpec.describe Board do
  subject(:board) {described_class.new}
  let(:sym1) {'◉'}
  let(:sym2) {'◎'}
  let(:empty_sym) {'◯'}
  describe '#display' do
    context 'when the grid is empty' do
      it 'returns an empty grid formated to printing to the cli' do
        empty_board = Array.new(6) {Array.new(7, empty_sym).join(' ')}
        expect(board.display).to eq(empty_board)
      end
    end
  end

  describe '#update' do
    context 'when given a column index and a symbol' do
      it 'updates the last empty cell with a given symbol in the column' do
        updated_column = Array.new(5, empty_sym) + [sym1]
        board.update(5, sym1)
        expect(board.grid[5]).to eq(updated_column)
      end
    end
  end

  describe '#valid_move?' do
    context 'when the column is filled' do
      it 'returns false' do 
        board.grid[1] = [sym1, sym1, sym2, sym2, sym1, sym1]
        expect(board.valid_move?(1)).to be(false)
      end
    end

    context 'when the column has empty cells' do
      it 'returns true' do
        board.grid[2] = [empty_sym, empty_sym, sym1, sym1, sym2, sym2]
        expect(board.valid_move?(2)).to be(true)
      end
    end

    context 'when provided with a valid index' do
      it 'returns true' do
        expect(board.valid_move?(6)).to be(true)
      end
    end

    context 'when provided with a non-existant index' do
      it 'returns false' do
        expect(board.valid_move?(8)).to be(false)
        expect(board.valid_move?(-2)).to be(false)
      end
    end
  end

  describe '#four_connected?' do
    context 'when the grid has four same symbols horizontally' do
      it 'returns true' do
        board.grid.each_with_index {|column, index| column[-1] = sym1 if index < 4}
        expect(board.four_connected?).to be(true)
      end
    end

    context 'when the grid has four same symbols vertically' do
      it 'returns true' do
        board.grid[3].each_with_index {|row, index| board.grid[3][index] = sym2 if index > 1}
        expect(board.four_connected?).to be(true)
      end
    end

    context 'when the grid has four same symbols on the first diagonal' do
      it 'returns true' do
        board.grid.each_with_index do |column, column_index|
          board.grid[column_index][column_index] = sym1 unless column_index > 3
        end
        expect(board.four_connected?).to be(true)
      end
    end

    context 'when the grid has four same symbols on the second diagonal' do
      it 'returns true' do
        board.grid.each_with_index do |column, column_index|
          board.grid[column_index][-column_index - 1] = sym1 unless column_index > 3
        end
        expect(board.four_connected?).to be(true)
      end
    end
  end

  describe '#draw?' do
    let(:symbols) {[sym1, sym2]}
    context 'when the board is full but there is no winner' do
      it 'returns true' do
        draw_grid = [
          [sym1, sym1, sym2, sym2, sym1, sym1],
          [sym2, sym2, sym1, sym1, sym2, sym2],
          [sym1, sym1, sym2, sym2, sym1, sym1],
          [sym2, sym2, sym1, sym1, sym2, sym2],
          [sym1, sym1, sym2, sym2, sym1, sym1],
          [sym2, sym2, sym1, sym1, sym2, sym2],
          [sym1, sym1, sym2, sym2, sym1, sym1]
        ]
        board.instance_variable_set(:@grid, draw_grid)
        expect(board.draw?).to be(true)
      end
    end

    context 'when the board is full and there is a winner' do
      it 'returns false' do
        grid_with_winner = [
          [sym1, sym1, sym1, sym1, sym2, sym2],
          [sym2, sym2, sym1, sym1, sym2, sym2],
          [sym1, sym1, sym2, sym2, sym1, sym1],
          [sym2, sym2, sym1, sym1, sym2, sym2],
          [sym1, sym1, sym2, sym2, sym1, sym1],
          [sym2, sym2, sym1, sym1, sym2, sym2],
          [sym1, sym1, sym2, sym2, sym1, sym1]
        ]
        board.instance_variable_set(:@grid, grid_with_winner)
        expect(board.draw?).to be(false)
      end
    end

    context 'when the board is not full' do
      it 'returns false' do
        grid_not_full = [
          [empty_sym, sym1, empty_sym, sym1, empty_sym, sym2],
          [empty_sym, sym2, sym1, sym1, sym2, sym2],
          [sym1, sym1, sym2, sym2, sym1, sym1],
          [sym2, sym2, sym1, sym1, sym2, sym2],
          [sym1, sym1, sym2, sym2, sym1, sym1],
          [sym2, sym2, sym1, sym1, sym2, sym2],
          [sym1, sym1, sym2, sym2, sym1, sym1]
        ]
        board.instance_variable_set(:@grid, grid_not_full)
        expect(board.draw?).to be(false)
      end
    end
  end
end