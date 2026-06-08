require_relative '../lib/player'

RSpec.describe Player do
  let(:display) {double('display')}
  let(:player) {described_class.new('◉', 'Player', display)}
  describe '#choose_column' do
    context 'when provided with a valid input' do
      it 'returns the entered number' do
        allow(display).to receive(:get_input).and_return('3')
        expect(player.choose_column).to eq(3)
      end
    end
    
    context 'when provided with an invalid input' do
      before do
        allow(display).to receive(:announce).with(any_args)
      end
      it 'loops until input is valid' do
        allow(display).to receive(:get_input).and_return('a','?','4')

        expect(display).to receive(:get_input).exactly(3).times
        expect(player.choose_column).to eq(4)
      end

      it 'rejects out-of-range numbers' do
        allow(display).to receive(:get_input).and_return('0', '9', '7')
        expect(player.choose_column).to eq(7)
      end

      it 'rejects multi-digit input' do
        allow(display).to receive(:get_input).and_return('11', '3')
        expect(player.choose_column).to eq(3)
      end
    end
  end
end