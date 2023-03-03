module ShapeArrayUtils
    
    # Returns a 2D array representing the shape with the given name.
    # WHY do we need this method: when entering the shape definitions, it's easier to enter the four unit squares that are filled, instead of manually entering all empty/full squares.
    #
    # Parameters:
    # - shape: A string representing the name of the shape to return.
    #
    # Returns:
    # A 2D array representing the shape with the given name.
    def return_shape_array(shape_name)
        # Get the list of coordinates for the given shape
        definitions = APP_SETTINGS[:shape_definitions]
        coords = definitions[shape_name]
    
        # Calculate the size of the shape array
        largest_x = coords.map { |c| c[:x] }.max
        largest_y = coords.map { |c| c[:y] }.max
    
        # Create a new array to represent the shape
        shape_array = Array.new(largest_y+1) { Array.new(largest_x+1, 0) }
    
        # Set the values of the shape array based on the coordinates
        coords.each do |coord|
            x = coord[:x]
            y = coord[:y]
            shape_array[y][x] = 1
        end
    
        # Return the shape array
        return shape_array
    end

end  