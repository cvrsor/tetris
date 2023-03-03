module UpdateGrid
    
    # Adds a given shape to the grid at a given position.
    #
    # Parameters:
    # - grid: A 2D array representing the current state of the grid, where each
    #         element of the array represents a cell in the grid and has a value of
    #         either 0 (empty) or a positive integer (indicating the shape number).
    # - shape_array: A 2D array representing the shape to be added to the grid, where
    #                each element of the array represents a cell in the shape and has
    #                a value of either 0 (empty) or 1 (indicating a filled cell).
    # - shape_number: An integer representing the number of the shape to be added to
    #                 the grid (its position in the sequence of shapes).
    # - starting_column: The column in the grid where the shape should be added.
    # - lowest_row: The lowest row in the grid where the shape can be added without
    #               colliding with any existing shapes.
    #
    # Returns:
    # The updated grid with the new shape added.
    def add_shape_to_grid(grid:, shape_array:, shape_number:, starting_column:, lowest_row:)
        shape_array.each_with_index { |shape_row, shape_row_index|
            shape_row.each_with_index { |shape_value, shape_column_index|
                grid_row_index = lowest_row + shape_row_index
                grid_column_index = starting_column + shape_column_index
                if shape_value == 1
                    grid[grid_row_index][grid_column_index] = shape_number
                end            
            }
        }
        return grid
    end

    # Check if an entire row is filled and clear it.
    #
    # If a row is filled, this method deletes it from the grid array and adds a new row
    # at the top of the grid filled with all zeros. Any higher rows drop into the vacated space
    # without any change to the internal pattern of blocks in any row.
    #
    # Parameters:
    # - grid: A 2D Array representing the game grid.
    # - debug: A boolean flag to indicate whether to display debug output
    #
    # Returns:
    # The updated grid with any completed rows removed.
    def clear_filled_rows(grid:, debug: false)
        
        completed_rows = []
        grid.each_with_index do |row, index|
            #if a row is completed, add it to the completed_rows array
            if row.all? { |val| val != 0}
                completed_rows << index
            end
        end
        
        # The completed_rows array contains the indexes of the rows that we want to delete from the grid array. 
        # We sort the completed_rows array in reverse order so that we can safely delete elements without changing the index positions of the remaining elements - ex if we need to clear more than one row. 
        # We then loop through the indexes to delete, calling delete_at on each index.
        completed_rows.sort.reverse_each do |row_index|
            puts "Filled row at row number: #{row_index}".colorize(:light_green) if debug
            grid.delete_at(row_index)
            grid_width = grid[0].length
            grid.push(Array.new(grid_width, 0))
        end
        return grid
    end
end