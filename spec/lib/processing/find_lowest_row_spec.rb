require_relative '../../../lib/processing/find_lowest_row.rb'

include FindLowestRow

RSpec.describe FindLowestRow do
  let(:empty_grid) do
    [
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0]
    ]
  end

  let(:full_grid) do
    [
      [1, 1, 0, 0, 0],
      [0, 1, 1, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0]
    ]
  end

  let(:shape_array) do
    [
      [1, 0, 0],
      [1, 1, 1]
    ]
  end

  describe '.find_lowest_row' do
    context 'when the shape reaches the top of another resting shape' do
      it 'returns the correct lowest row number the shape can land' do
        expect(subject.find_lowest_row(grid: full_grid, shape_array: shape_array, starting_column: 1)).to eq(2)
      end
    end

    context 'when the shape touches the bottom' do
      let(:shape_array) do
        [
          [1, 1, 1],
          [0, 0, 1]
        ]
      end

      it 'returns 0 as the lowest row number' do
        expect(subject.find_lowest_row(grid: empty_grid, shape_array: shape_array, starting_column: 1)).to eq(0)
      end
    end

  end

  describe '.shape_fits_at_row?' do
    context 'when the shape fits in the grid' do
      it 'returns true' do
        expect(subject.send(:shape_fits_at_row?, full_grid, shape_array, 1, 3)).to be true
      end
    end

    context 'when the shape overlaps with an existing shape' do
      before do
        full_grid[2][2] = 1
      end

      it 'returns false' do
        expect(subject.send(:shape_fits_at_row?, full_grid, shape_array, 1, 0)).to be false
      end
    end
  end

  describe '.grid_value_at' do
    it 'returns the correct value for a valid cell' do
      expect(subject.send(:grid_value_at, full_grid, 0, 0)).to eq(1)
    end

    it 'returns 0 for an invalid cell' do
      expect(subject.send(:grid_value_at, full_grid, 10, 10)).to eq(0)
    end
  end
end
