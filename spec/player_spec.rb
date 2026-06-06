require_relative '../lib/player'

RSpec.describe Player do
  let(:player) {described_class.new('◉', 'Player')}
  describe '#choose_column' do
    context 'when provided with a valid input' do
      it 'returns the entered number' do
        allow(player).to receive(:gets).and_return('3')
        expect(player.choose_column).to eq(3)
      end
    end

    context 'when provided with an invalid input' do
      it 'loops until input is valid' do
        allow(player).to receive(:gets).and_return('a','?','4')
        expect(player).to receive(:gets).exactly(3).times
        expect(player.choose_column).to eq(4)
      end

      it 'rejects out-of-range numbers' do
        allow(player).to receive(:gets).and_return('0', '9', '7')
        expect(player.choose_column).to eq(7)
      end

      it 'rejects multi-digit input' do
        allow(player).to receive(:gets).and_return('11', '3')
        expect(player.choose_column).to eq(3)
      end
    end
  end
end