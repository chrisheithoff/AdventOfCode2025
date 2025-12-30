# Advent of Code 2025.  
# Day 06: Trash Compactor
# Part 2: Now use cephalapod right-to-left column math

source ../aoc_library.tcl

set data [file_to_list "demo.txt"]
# set data [file_to_list "input.txt"]

# Treat each row as text, including the whitespace.
set number_rows [lrange $data 0 end-1]
set operators   [lindex $data end]

# Start at the right-most column and move left to get number and the operator
#  (each column might have different widths, so check all
set max_columns 0
foreach row $number_rows {
    if {[string length $row] > $max_columns} {
        set max_columns [string length $row]
    }
}

# Initialize the loop variables
set i [expr {$max_columns - 1}]
set numbers [list]
set part2_ans 0

while {$i >= 0} {
    # Form a number by reading vertically down this column
    set number ""
    foreach row $number_rows {
        set digit [string index $row $i]
        if {[string is digit $digit]} {
            append number $digit
        }
    }

    lappend numbers $number

    # If this column has an operator:
    #    - do the calculation
    #    - reset the list of numbers
    #    - move index one more to the left (to skip through the column with only whitespace)
    set operator [string index $operators $i]
    if {$operator in "+ *"} {
        set calculation [tcl::mathop::${operator} {*}$numbers] 
        incr part2_ans $calculation
        puts "  [join $numbers $operator] = $calculation"
        set numbers [list]
        incr i -2
    } else {
        incr i -1
    }
}

puts "Part 2 answer: $part2_ans"
