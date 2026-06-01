require_relative '../lib/board'

RSpec.describe Board do
  subject(:board) {described_class.new}
  let(:sym1) {'◉'}
  let(:sym2) {'◎'}
  let(:empty_sym) {'◯'}
  describe '#display' do
    context 'when the grid is empty' do
      it 'prints an empty grid to the cli' do
        empty_board = Array.new(6) {Array.new(7, empty_sym).join(' ')}
        expect(board).to receive(:puts).with(empty_board)
        board.display
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
          board.grid[column_index][column_index + 1] = sym1 unless column_index > 3
        end

        expect(board.four_connected?).to be(true)
      end
    end

    context 'when the grid has four same symbols on the second diagonal' do
      it 'returns true' do
        board.grid.each_with_index do |column, column_index|
          offset = 1
            board.grid[column_index][-column_index - offset] = sym1 unless column_index > 5
          offset += 1
        end
        expect(board.four_connected?).to be(true)
      end
    end
  end
end