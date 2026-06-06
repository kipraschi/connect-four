require_relative '../lib/game'

RSpec.describe Game do
  describe "#play" do
    let(:player1) {double('player1', marker: '◉')}
    let(:player2) {double('player2', marker: '◎')}
    let(:board) {double('board')}
    let(:game) {described_class.new(player1, player2, board)}

    context 'until the game is over' do
      before do
        allow(game).to receive(:announce).with(any_args)
        allow(game).to receive(:game_over?).and_return(false, false, true)
        allow(player1).to receive(:choose_column).and_return(4)
        allow(player2).to receive(:choose_column).and_return(3)
        allow(board).to receive(:update)
        allow(board).to receive(:display)
        allow(board).to receive(:draw?).and_return(true)
        allow(board).to receive(:valid_move?).and_return(true)
      end
      it 'gets an input from each player' do
        expect(player1).to receive(:choose_column)
        expect(player2).to receive(:choose_column)
        game.play
      end
      it 'calls Board#update ' do
        expect(board).to receive(:update)
        game.play
      end
      it 'calls Board#display' do
        expect(board).to receive(:display)
        game.play
      end
    end

    context 'when one of the selected columns is not available' do
      before do
        allow(game).to receive(:announce).with(any_args)
        allow(game).to receive(:game_over?).and_return(false, true)
        allow(player1).to receive(:choose_column).and_return(8, 3)
        allow(board).to receive(:update)
        allow(board).to receive(:display)
        allow(board).to receive(:draw?).and_return(true)
        allow(board).to receive(:valid_move?).and_return(false, true)
      end
      it 'calls Player#choose_column three times' do
        expect(player1).to receive(:choose_column).twice
        game.play
      end
    end

  end
end
