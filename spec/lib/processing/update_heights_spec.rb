require_relative '../../../lib/processing/update_heights.rb'

include UpdateHeights

describe UpdateHeights do
  describe ".update_heights" do
    context "when given a grid with no shapes" do
      it "returns an array with zero heights" do
        grid = [ [0, 0, 0], [0, 0, 0], [0, 0, 0] ]
        heights = [0, 0, 0]

        result = update_heights(grid: grid, heights: heights)

        expect(result).to eq([0, 0, 0])
      end
    end

    context "when given a 3x3 grid with one shape" do
      it "returns an array with the correct heights" do
        grid = [ [1, 1], [1, 0], [1, 0] ]
        heights = [0, 0, 0]

        result = update_heights(grid: grid, heights: heights)

        expect(result).to eq([3, 1, 0])
      end
    end

    context "when given a 5x4 grid that has two different shapes" do
      it "returns an array with the correct heights" do
        grid = [ [1, 1, 0, 0, 0], [0, 1, 1, 0, 0], [0, 0, 2, 2, 0], [0, 0, 0, 2, 2] ]
        heights = [0, 0, 0, 0, 0]

        result = update_heights(grid: grid, heights: heights)
        expect(result).to eq([1, 2, 3, 4, 4])
      end
    end
  end
end
