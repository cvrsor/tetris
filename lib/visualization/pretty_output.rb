module PrettyOutput
    include ShapeArrayUtils
    # This method takes a 2D array (ex. the grid) and prints it. Each non-zero element in the array is represented with colored characters.
    # Empty squares are represented with a white square, and each filled square is coloured.
    # Each shape is printed using the same color.
    # 
    # Parameters:
    # - arr: A 2D array to be printed
    # - show_horizontal_axis: A boolean flag to show/hide the horizontal axis of the grid
    #
    # Returns nothing
    def pretty_print_array(arr:, show_horizontal_axis: false)
        # Define all possible coloured square characters
        full_chars = ['🟫', '🟩', '⬛️', '🟥', '🟦', '🟧', '🟪', '🟨', '🔴', '⚫️', '🔵', '🟣', '🟡', '🟤', '🟢', '🟠', '❇️ ','✴️ ', '✳️ ','Ⓜ️']
        # Define the empty square character
        empty = '⬜️'
         # Create a hash to hold block colors for each shape
        block_colors = {}
        # Create an array of available characters that haven't been used
        avail_chars = []
        first_empty_row = find_row_with_first_empty_block(arr)
        display_array = arr
        if first_empty_row.nil? == false
            display_array = arr.slice(0, first_empty_row+2)
        end
        
        display_array.reverse.each_with_index { |row, index|
            if avail_chars.empty?
                #if we have exhausted all characters, re-use colors
                avail_chars = full_chars
            end

            # Join each element of the row with its corresponding block character
            color_coded_row = row.map {|i|
                if i == 0
                    # If the element is 0, use the empty block character
                    empty
                else
                    # Draw a colored character
                    if block_colors.has_key?(i) == false
                        #new block shape, get a new color for this block
                        block_colors[i] = avail_chars.shift #use the first item of the full_chars array (and remove it from the array)
                    end
                    # Return the block_color
                    block_colors[i]
                end
            }.join('')

            # Pad the row index with leading zeros for better formatting
            padded_index = "%02d" % (display_array.length - 1 - index)

            # Print the row with its index and colored blocks
            puts "#{padded_index}: ".colorize(:light_magenta) +  "#{color_coded_row}"
        }
        if show_horizontal_axis
            puts "    0 1 2 3 4 5 6 7 8 9".colorize(:light_magenta) #grid width
        end
    end

    
    # Pretty prints all possible shapes
    #
    # Returns nothing
    def pretty_print_all_shapes()
        APP_SETTINGS[:shape_definitions].each_key { |shape_name|
            shapeArray = return_shape_array(shape_name)
            puts "Printing shape: #{shape_name}".colorize(:light_cyan)
            pretty_print_array(arr: shapeArray)
        }
    end

private
    # Finds the index of the first row in the array where the first empty block occurs
    #
    # Parameters:
    # - arr: An array of arrays representing a grid
    #
    # Returns:
    # The index of the first empty row in the array where the first empty block occurs, or nil if no such row is found
    def find_row_with_first_empty_block(arr)
        arr.each_with_index { |row, index|
            if row.uniq == [0]
                return index
            end
        }
        #if there aren't any empty rows, return nil
        return nil
    end

end