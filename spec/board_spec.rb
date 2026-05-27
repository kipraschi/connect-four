require_relative '../lib/board'

RSpec.describe Board do
  subject(:board) {described_class.new}
  describe '#display' do
    context 'when the grid is empty' do
      it 'prints an empty grid to the cli' do
        empty_board = Array.new(6) {'〇〇〇〇〇〇〇'}
        expect(board).to receive(:puts).with(empty_board)
        board.display
      end
    end
  end
  describe '#update' do
    context 'when given a column index and a symbol' do
      it 'updates the last empty cell with a given symbol in the column' do
        updated_column = ['〇','〇','〇','〇','〇','➊']
        board.update(5, '➊')
        expect(board.grid[5]).to eq(updated_column)
      end
    end
  end

end