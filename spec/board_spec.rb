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
end