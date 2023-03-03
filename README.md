
# Tetris

  

'Tetris' is a command-line Ruby application that models a simplified Tetris engine. It processes a text file of lines representing a sequence of pieces entering the grid and outputs the resulting height of the remaining blocks within the grid.

  

## Live Demo

  

You can test the utility on Replit: **[https://replit.com/@Cvrsor/tetris](https://replit.com/@Cvrsor/tetris)**

Hit the 'Play' icon to start the VM. You can then enter any **tetris** commands at the prompt:

  

```ruby

./bin/tetris < data/input.txt  > output.txt

```

_(Replit VMs can sometimes be slow. The CLI performs better when installed locally)_

  

## Installation

  

To install, simply clone this repository and then execute:

  

```ruby

bundle install

```

You may also need to add executable permissions to the `bin/tetris` script:

```console

chmod +x bin/tetris

```

  

#### Prerequisites

Ruby version 2 or higher. Tested with Ruby v.3.2.0.

  

## Usage

```bash

./bin/tetris <  data/input.txt  >  output.txt

```

  

Run `./bin/tetris --help` to view the CLI's help notes and available options:

  

#### Command-line Options:

I've added a few additional command-line options that visualise the grid results and display debug information. These optionsa are alall

  

* `-v, --visualize-grid` Shows a visual representation of the final tetris board after all pieces have been placed.

* `-d, --debug` Displays debug information

* `-s, --display-shapes` Displays all the different shapes that can be used in the tetris game.

* `-c, --do-not-clear-lines` Disables the default behavior of clearing filled lines on the tetris board.

* `-h, --help` Displays the available options and their descriptions for the command line application.

  

#### Examples:

Simple form - output directed to a file:

`./bin/tetris < data/input.txt > output.txt`

  

Simple form - output displayed in the console:

`./bin/tetris < data/input.txt`

  

Use the -v option to visualise results:

`./bin/tetris -v < data/input.txt`

  

<img  src="https://dbpclsv0nmaf4.cloudfront.net/tetris/visualize-grid2.png"  height="300">

  

Use the -s option to display all available shapes (useful for debugging):

`./bin/tetris -s < data/input.txt`

  

<img  src="https://dbpclsv0nmaf4.cloudfront.net/tetris/shapes.png"  height="500">

  

Use the -d option to view verbose output:

`./bin/tetris -d < data/input.txt`

  

<img  src="https://dbpclsv0nmaf4.cloudfront.net/tetris/debug-output.png"  height="140">

## Source code notes

  

The application has minimal external dependencies, specifically: the [Rspec](https://rspec.info/) gem, an established BDD testing framework for ruby used for the app's tests. The app also uses the [colorize](https://github.com/fazibear/colorize) gem to colorise text using ANSI escape sequences (used in visualising the grid).

  

The CLI's main code is in [/bin/tetris](https://github.com/cvrsor/tetris/blob/master/bin/tetris).

  

The /lib folder has the [tetris_game.rb](https://github.com/cvrsor/simple-tetris/blob/master/lib/tetris_game.rb) class and related modules. The TetrisGame class is responsible for accepting one sequence of shapes and returning the resulting height of the grid after all shapes have been added. This Ruby class serves as a reusable module for simulating Tetris games with different sequences, enabling clean and organized code.

  

To enhance the code's readability and maintainability, the tetris engine code is divided into several modules:

* `processing/update_grid.rb` add a Tetris shape to the grid, clear filled rows from the grid.

* `processing/update_heights.rb` keep track of maximum height of each column.

* `processing/find_lowest_row.rb` find the lowest row where a given shape can land.

* `processing/shape_array_utils.rb` return an 2D array representation of a shape.

* `visualization/pretty_output.rb` display a visual representation of the grid.

  

## Tests

  

Tests for the CLI are located in the [/spec](https://github.com/cvrsor/tetris/tree/master/spec) directory.

  

The spec folder structure follows the app's folder structure. Each `*.rb` file has a corresponding `*_spec.rb` file. For example, `tetris_game_spec.rb` file contains test cases for the `tetris_game.rb` class.

  

You can run the tests using `rake spec` command, which outputs:

  

```rspec
FindLowestRow
  .find_lowest_row
    when the shape reaches the top of another resting shape
      returns the correct lowest row number the shape can land
    when the shape touches the bottom
      returns 0 as the lowest row number
  .shape_fits_at_row?
    when the shape fits in the grid
      returns true
    when the shape overlaps with an existing shape
      returns false
  .grid_value_at
    returns the correct value for a valid cell
    returns 0 for an invalid cell

ShapeArrayUtils
  .return_shape_array
    when given a shape with one coordinate
      returns a 2D array with the correct unit squares filled
    when given a shape with multiple coordinates
      returns a 2D array with the correct unit squares filled

UpdateGrid
  .add_shape_to_grid
    returns the expected grid array
  .clear_filled_rows
    returns the expected grid array

UpdateHeights
  .update_heights
    when given a grid with no shapes
      returns an array with zero heights
    when given a 3x3 grid with one shape
      returns an array with the correct heights
    when given a 5x4 grid that has two different shapes
      returns an array with the correct heights

TetrisGame
  #initialize
    sets the instance variables correctly
  #find_blocks_height
    when the sequence has one shape
      returns the correct maximum height
    when the sequence has multiple shapes
      returns the correct maximum height
    when the sequence has multiple shapes and one row is filled (cleared)
      returns the correct maximum height
    when one row is filled but the --do-not-clear-lines option is present
      returns the correct maximum height

Tetris app
  processes input from STDIN and produces output

Finished in 0.5088 seconds (files took 0.12603 seconds to load)
19 examples, 0 failures
```
