require_relative '../../lib/tetris_game.rb'

RSpec.describe TetrisGame do
  let(:options) { { show_debug_info: false, visualize_grid: false, clear_lines: true } }
  subject(:tetris_game) { described_class.new(sequence, options) }

  describe '#initialize' do
    let(:sequence) { 'I0,J1,L2' }

    it 'sets the instance variables correctly' do
      expect(tetris_game.instance_variable_get(:@DEBUG)).to eq(false)
      expect(tetris_game.instance_variable_get(:@VISUALIZE_GRID)).to eq(false)
      expect(tetris_game.instance_variable_get(:@CLEAR_LINES)).to eq(true)
      expect(tetris_game.instance_variable_get(:@GRID_WIDTH)).to eq(10)
      expect(tetris_game.instance_variable_get(:@GRID_HEIGHT)).to eq(100)
      expect(tetris_game.instance_variable_get(:@sequence)).to eq(sequence)
    end
  end

  describe '#find_blocks_height' do
    context 'when the sequence has one shape' do
      let(:sequence) { 'I0' }

      it 'returns the correct maximum height' do
        expect(tetris_game.find_blocks_height).to eq(1)
      end
    end

    context 'when the sequence has multiple shapes' do
      let(:sequence) { 'S0,S2,S4,S6' }

      it 'returns the correct maximum height' do
        expect(tetris_game.find_blocks_height).to eq(8)
      end
    end

    context 'when the sequence has multiple shapes and one row is filled (cleared)' do
        let(:sequence) { 'I0,I6,S4' }

        it 'returns the correct maximum height' do
            expect(tetris_game.find_blocks_height).to eq(1)
        end
    end

    context 'when one row is filled but the --do-not-clear-lines option is present' do
        let(:sequence) { 'I0,I6,S4' }

        before do
          options[:clear_lines] = false
        end

        it 'returns the correct maximum height' do
            expect(tetris_game.find_blocks_height).to eq(2)
        end
    end

  end
end
