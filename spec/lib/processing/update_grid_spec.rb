require_relative '../../../lib/processing/update_grid.rb'

include UpdateGrid

describe UpdateGrid do
  describe ".add_shape_to_grid" do
    let(:grid) { Array.new(5) { Array.new(5, 0) } }
    let(:shape_array) {
      [
        [1, 1],
        [1, 1]
      ]
    }
    let(:shape_number) { 1 }
    let(:starting_column) { 2 }
    let(:lowest_row) { 2 }
    let(:expected_result) {
      [
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 1, 1, 0],
        [0, 0, 1, 1, 0],
        [0, 0, 0, 0, 0]
      ]
    }

    it "returns the expected grid array" do
      result = add_shape_to_grid(
        grid: grid,
        shape_array: shape_array,
        shape_number: shape_number,
        starting_column: starting_column,
        lowest_row: lowest_row
      )

      expect(result).to eq(expected_result)
    end
  end

  describe ".clear_filled_rows" do
    let(:grid) {
      [
        [1, 1, 1, 1, 1],
        [0, 2, 2, 2, 0],
        [0, 3, 0, 3, 3],
        [4, 4, 0, 0, 0],
        [0, 0, 0, 0, 0]
      ]
    }
    let(:expected_result) {
      [
        [0, 2, 2, 2, 0],
        [0, 3, 0, 3, 3],
        [4, 4, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0]
      ]
    }

    it "returns the expected grid array" do
      result = clear_filled_rows(grid: grid)
      expect(result).to eq(expected_result)
    end
    
  end
end
