#!/bin/env ruby



#This loads Ruby’s standard Pathname library, which provides methods to handle and manipulate file paths in a clean, object-oriented way. It’s used later to get relative paths.
require "pathname"

# This reads an assembly code file, and reads the entire file content as a single string and assigns the string it to prog.
# So prog is a single string containing an entire assembly code file
prog = File.read(ARGV[0])

# splits the assembly code into lines and stores it in an array. Each line of code is another element in the array
prog = prog.split("\n")

# This maps out each element in the array (which is basically every each assembly line code) to a '#' symbol, which is the symbol for a comment
# This essentially shows the assembly code lines, but as comments because the "#" is in front of each line
prog = prog.map {|l| "# #{l}"}
prog = prog.join("\n")

#This converts the input filename to an absolute file path — so it knows exactly where the file lives on your disk.
absfilename = File.absolute_path(ARGV[0])
path = File.dirname(__dir__) # root of scripts folder
relfilename = Pathname.new(absfilename).
  relative_path_from(Pathname.new(path))

# run the program through customasm as well
# hex holds the machine code of the instructions. However, there is an extra line in this string called the header which needs to be stripped
hex = `cd #{path} && customasm -f logisim16 -p -q #{relfilename}`

# split hex into lines, and it take all but the first (header) line
_, *lines = hex.split("\n")

# split all the lines on spaces
machcode = lines.map {|x| x.split}

# flatten an array of arrays to a single large array
machcode = machcode.flatten

# add `0x` prefix to each hex number
machcode = machcode.map {|x| "0x#{x}"}

# print the template for digital test cases
puts <<~DONE
  clock run error halt

  #{prog}

  program(#{machcode.join(", ")})

  let i = 0;
  while(!(halt | error | (i >= 100)))
    let i = i + 1;
    0 1 0 0
    1 1 x x
  end while
  0 1 0 1
DONE