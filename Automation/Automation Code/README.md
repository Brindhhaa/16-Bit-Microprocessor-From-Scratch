## 📄 What This Ruby Script Does

This Ruby script automates the process of assembling a custom 16-bit microprocessor program and generating a ready-to-use simulation testbench. Here’s how it works:

---

###  1. Reads your assembly source file  
It takes a single input file (provided as a command-line argument) and reads its entire content.

###  2. Comments the source for documentation  
Every line of your original assembly code is automatically turned into a comment. This makes it easy to include the original code in test cases without affecting execution.

###  3. Runs the assembler (`customasm`)  
It then runs [`customasm`](https://github.com/HLorenzi/customasm) — an open-source assembler — to translate your assembly code into machine code formatted specifically for Logisim or other digital circuit simulators.

###  4. Processes the machine code output  
It parses the assembler’s output, cleans it up, and converts each instruction into a properly formatted hexadecimal literal.

###  5. Generates a simulation template  
Finally, the script prints a complete simulation testbench that:
-  Includes your commented source code
-  Loads the assembled machine code into the simulator
-  Defines a simple clock and control loop to automatically run your program for up to **100 cycles** or until it halts or errors

---

This makes testing your custom CPU design easy and repeatable — you get a single output you can copy directly into your simulator.

