require_relative '../config/settings.rb'
require_relative 'processing/find_lowest_row.rb'
require_relative 'processing/shape_array_utils.rb'
require_relative 'processing/update_grid.rb'
require_relative 'processing/update_heights.rb'
require_relative 'visualization/pretty_output.rb'

class TetrisGame
    include FindLowestRow
    include ShapeArrayUtils
    include UpdateGrid
    include UpdateHeights
    include PrettyOutput

    def initialize(sequence, options)
        @DEBUG = options[:show_debug_info]
        @VISUALIZE_GRID = options[:visualize_grid]
        @CLEAR_LINES = options[:clear_lines]
        @GRID_WIDTH = APP_SETTINGS[:grid_width]
        @GRID_HEIGHT = APP_SETTINGS[:grid_height]
        @sequence = sequence
    end

    # Calculates the resulting height of the grid the sequence of shapes have been added.
    #
    # Parameters:
    # - sequence: A comma-separated string representing the sequence of shapes to be added to the grid.
    #
    # Returns:
    # The maximum height of the game grid after all the shapes have been added.
    def find_blocks_height()   
        # Define the initial game state
        grid = Array.new(@GRID_HEIGHT) { Array.new(@GRID_WIDTH, 0) }
        # heights: stores the maximum height of each column in the game grid. 
        # Each element of the heights array represents the maximum height of the corresponding column in the game grid.
        heights = Array.new(@GRID_WIDTH, 0)

        puts "\nSequence: #{@sequence}".colorize(:light_cyan) if @DEBUG || @VISUALIZE_GRID
        shapes = @sequence.strip.split(',')
        shapes.each_with_index { |shape_column_val, shape_index|
            shape, starting_column = shape_column_val.split(//) #split the string
            starting_column = starting_column.to_i
            
            # Get the shape array for the current shape
            shape_array = return_shape_array(shape)
    
            # Find the lowest row that the shape can occupy in the given column
            lowest_row = find_lowest_row(grid: grid, shape_array: shape_array, starting_column: starting_column)
            puts "Shape #{shape} landed on row number: #{lowest_row}".colorize(:yellow) if @DEBUG
    
            # Add this shape to the grid
            grid = add_shape_to_grid(grid: grid, shape_array: shape_array, shape_number: shape_index+1, starting_column: starting_column, lowest_row: lowest_row)
    
            # Check if an entire row is filled. Any higher rows drop into the vacated space without any change to the internal pattern of blocks in any row
            grid = clear_filled_rows(grid: grid, debug: @DEBUG) if @CLEAR_LINES
    
            # Update the heights of each column
            heights = update_heights(grid: grid, heights: heights)
        }
        
        # calculate the result (Maximum height) using the heights array
        max_height = heights.max
                
        #display a visual representation of the grid
        pretty_print_array(arr: grid, show_horizontal_axis: true) if @VISUALIZE_GRID
        puts "Max height: #{max_height}".colorize(:light_yellow) if @DEBUG || @VISUALIZE_GRID
        return max_height
    end    
    
end
