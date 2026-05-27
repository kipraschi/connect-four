require_relative '../lib/board'

RSpec.describe Board do
  subject(:grid) {described_class.new}
  describe '#display' do
    context 'when the grid is empty' do
      it 'prints an empty grid to the cli' do
        empty_board = Array.new(6) {'〇〇〇〇〇〇〇'}
        expect(grid).to receive(:puts).with(empty_board)
        grid.display
      end
    end
  end

end