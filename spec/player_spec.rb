require 'player'

RSpec.describe Player do
  context 'computer player' do
    subject(:player) { described_class.new('X', 'Computer') }
    it 'should have X marker for computerplayer' do
      expect(player.marker).to eq('X')
    end

    it 'should have correct name for computer player' do
      expect(player.name).to eq('Computer')
    end
  end

  context 'human player' do
    subject(:player) { described_class.new('X', 'Human') }
    it 'should have X marker for computerplayer' do
      expect(player.marker).to eq('X')
    end

    it 'should have correct name for computer player' do
      expect(player.name).to eq('Human')
    end
  end
end
