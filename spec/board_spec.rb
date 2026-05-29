require_relative '../lib/board'

RSpec.describe Board do
  subject(:board) {described_class.new}
  describe '#display' do
    context 'when the grid is empty' do
      it 'prints an empty grid to the cli' do
        empty_board = Array.new(6) {'◯ ◯ ◯ ◯ ◯ ◯ ◯'}
        expect(board).to receive(:puts).with(empty_board)
        board.display
      end
    end
  end

  describe '#update' do
    context 'when given a column index and a symbol' do
      it 'updates the last empty cell with a given symbol in the column' do
        updated_column = ['◯','◯','◯','◯','◯','◉']
        board.update(5, '◉')
        expect(board.grid[5]).to eq(updated_column)
      end
    end
  end

  describe '#invalid_move?' do
    let(:grid) {Array.new(7) { Array.new(6) { '◯' } } }
    
    context 'when the column is filled' do
      it 'returns true' do 
        board.grid[1] = ['◉','◉','◎','◎','◉','◉']
        expect(board.invalid_move?(1)).to be(true)
      end
    end

    context 'when the column has empty cells' do
      it 'returns false' do
        board.grid[2] = ['◯','◯','◉','◉','◎','◎']
        expect(board.invalid_move?(2)).to be(false)
      end
    end

    context 'when provided with a valid index' do
      it 'returns false' do
        expect(board.invalid_move?(6)).to be(false)
      end
    end

    context 'when provided with a non-existant index' do
      it 'returns true' do
        expect(board.invalid_move?(8)).to be(true)
        expect(board.invalid_move?(-2)).to be(true)
      end
    end
    

  end

end