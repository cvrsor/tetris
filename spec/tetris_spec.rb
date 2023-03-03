# To test the main ruby app we can use an RSpec test file with a test that simulates running the app and piping the contents of the input.txt file into it.
RSpec.describe "Tetris app" do
    it "processes input from STDIN and produces output" do
      # Prepare the test input
      input_file_path = File.expand_path('../data/input.txt', __dir__)
      test_input = File.read(input_file_path)
      
      # Run the app and capture the output
      tetris_file_path = File.expand_path('../bin/tetris', __dir__)
      output = %x(ruby "#{tetris_file_path}" < data/input.txt)
      
      # Parse the output into an array of integers
      sequence_heights = output.split("\n").map(&:to_i)

      # Perform the assertions
      expect(sequence_heights).to eq([2, 4, 0, 2, 4, 1, 0, 2, 2, 2, 1, 1, 4, 3, 1, 2, 1, 8, 8, 0, 3])
    end
  end
  