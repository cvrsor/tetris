module FindLowestRow
    # Finds the lowest row where a given shape can be placed in the grid (either it will touch the bottom (row 0), or sit on top of another resting block)
    #
    # Parameters:
    # - grid: An array representing the game grid, where each element represents a block and has a value of 0 (empty) or a positive integer (shape identifier).
    # - shape_array: An array representing the shape to be placed in the grid, where each element represents a block and has a value of 0 (empty) or 1 (part of the shape).
    # - starting_column: The column where the leftmost block of the shape will be placed.
    #
    # Returns:
    # An integer representing the lowest row number where the shape can be placed in the grid
    def find_lowest_row(grid:, shape_array:, starting_column:)
        initial_row = grid.length - shape_array.length
        initial_row.downto(0) { |row_number|
            if shape_fits_at_row?(grid, shape_array, starting_column, row_number) == false
                return row_number + 1 # return the previous row number, which is a valid position
            end
        }
        #shape touched bottom, return row number 0
        return 0
    end

private

    # Checks whether a given shape can fit in the grid at a given row. No two squares can occupy the same space in the grid at the same time
    #
    # Parameters:
    # - grid: An array representing the game grid, where each element represents a block and has a value of 0 (empty) or a positive integer (shape identifier).
    # - shape_array: An array representing the shape to be placed in the grid, where each element represents a block and has a value of 0 (empty) or 1 (part of the shape).
    # - starting_column: The column where the leftmost block of the shape will be placed.
    # - row_number: The row number where the topmost block of the shape will be placed.
    #
    # Returns:
    # A boolean indicating whether the shape can be placed in the grid at the given row.
    def shape_fits_at_row?(grid, shape_array, starting_column, row_number)
        # Loop over each row in the shape array
        shape_array.each_with_index { |shape_row, shape_row_index|
            # Loop over each column in the row
            shape_row.each_with_index { |shape_value, shape_column_index|
                # Calculate the corresponding row number and column number in the grid
                grid_row_index = row_number + shape_row_index
                grid_column_index = starting_column + shape_column_index
                
                # Check if the current unit square overlaps with an existing unit square in the grid
                if shape_value != 0 && grid_value_at(grid, grid_row_index, grid_column_index) != 0
                    # the unit square is taken, so stop looping and return false
                    return false
                end
            }
        }
        # shape fits at the given row
        return true
    end

    
    # Returns the value of a given cell in the grid, or 0 if the cell is out of bounds.
    #
    # Parameters:
    # - grid: An array representing the game grid, where each element represents a block and has a value of 0 (empty) or a positive integer (shape identifier).
    # - row: The row index of the cell to retrieve.
    # - column: The column index of the cell to retrieve.
    #
    # Returns:
    # The value of the cell at the given row and column, or 0 if the cell is out of bounds.
    def grid_value_at(grid, row, column)
        # Check if the row and column are within the bounds of the grid
        if row < 0 || row >= grid.length || column < 0 || column >= grid[0].length
            # If the cell is out of bounds, return 0
            return 0
        else
            # Otherwise, return the value of the cell
            return grid[row][column]
        end
    end

end
