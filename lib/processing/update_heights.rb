module UpdateHeights
    # Update the heights of each column in the grid based on the current state of the grid.
    #
    # Parameters:
    # - grid: A 2D array representing the current state of the game grid, where each
    #         element of the array represents a cell in the grid and has a value of
    #         either 0 (empty) or a positive integer (indicating the shape number).
    # - heights: An array representing the current heights of each column in the grid,
    #            where each element of the array represents the height of a column and
    #            has a value of either 0 (empty) or a positive integer (indicating the
    #            highest occupied row in the column).
    # - debug: A boolean indicating whether to output debugging information to the console.
    #
    # Returns:
    # An array representing the updated heights of each column in the grid.
    def update_heights(grid: , heights: , debug: false)
        grid_width = grid[0].length
        grid_height = grid.length
        (0..(grid_width - 1)).each_with_index do |column_number, index|
            #first find the column values            
            column_values = []
            (0..(grid_height - 1)).each_with_index { |row_number| #for each grid row
                #return an array where the first number is the row number, and the second number the grid value at that row
                grid_value = grid[row_number][column_number]
                column_values << [row_number, grid_value]
            }
            highest_row_number = get_highest_row_number(array_of_arrays: column_values)
            # If the grid is not empty, add 1 to the maximum height to account for the bottom row (our grid height is represented by a zero-based array)
            if grid.flatten.uniq != [0]
                highest_row_number = highest_row_number + 1
            end
            heights[column_number] = highest_row_number
        end
        return heights
    end

private
    # Returns the highest row number with a non-zero value
    #
    # Parameters:
    # - array: Accepts a 2d array of column values
    #          (each column value is an array, where the first number represents the row number, 
    #           and the second number represents the grid value at that row)
    #
    # Returns:
    # An integer representing the highest row number with a non-zero value
    def get_highest_row_number(array_of_arrays:)
        # max_by returns the inner array with the highest value returned by the block. 
        highest_row_number_element = array_of_arrays.max_by do |inner_array|
            row_number = inner_array[0]
            cell_value = inner_array[1]
            if cell_value != 0  # if the value is 1
                row_number  # return the row number
            else
            0  # otherwise, return 0
            end
        end
        return highest_row_number_element[0] #return the row number
    end
end