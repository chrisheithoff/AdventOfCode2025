# Advent of Code 2025.  
# Day 06: Trash Compactor
# Part 1: What is the grand total found by adding together all of the answers to the 
#         individual problems? 

source ../aoc_library.tcl

set data [file_to_list "demo.txt"]
set data [file_to_list "input.txt"]

set data [rotate_left $data]

set part1_ans 0
foreach row $data {
    set numbers  [lrange $row 0 end-1]
    set operator [lindex $row end]
    set calculation [tcl::mathop::${operator} {*}$numbers] 
    incr part1_ans $calculation
}
puts "Part 1 answer: $part1_ans"
