require_relative '../../../config/settings.rb'
require_relative '../../../lib/processing/shape_array_utils.rb'

include ShapeArrayUtils
describe ShapeArrayUtils do
    describe ".return_shape_array" do
        context "when given a shape with one coordinate" do
            it "returns a 2D array with the correct unit squares filled" do
                shape_name = "test_shape"
                definitions = { shape_name => [{ x: 0, y: 0 }] }
                allow(APP_SETTINGS).to receive(:[]).with(:shape_definitions).and_return(definitions)

                result = ShapeArrayUtils.return_shape_array(shape_name)

                expect(result).to eq([[1]])
            end
        end

        context "when given a shape with multiple coordinates" do
            it "returns a 2D array with the correct unit squares filled" do
                shape_name = "test-Z-shape"
                definitions = { shape_name => [{x: 0, y: 1}, {x: 1, y: 0}, {x: 1, y: 1}, {x: 2, y: 0}] }
                allow(APP_SETTINGS).to receive(:[]).with(:shape_definitions).and_return(definitions)

                result = ShapeArrayUtils.return_shape_array(shape_name)

                expect(result).to eq([[0, 1, 1], [1, 1, 0]])
            end
        end

    end
end