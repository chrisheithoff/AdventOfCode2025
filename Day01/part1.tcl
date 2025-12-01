# Advent of Code 2025.  
# Day 01:  Secret Entrance
# Part 1:  Find the number of times that a dial on a safe is pointing to 0

source ../aoc_library.tcl

# set data [exec cat demo.txt]
set data [exec cat input.txt]

set dial_pos 50
set times_at_zero 0

foreach move $data {
    set dir [string index $move 0]
    set amount    [string range $move 1 end]

    # Move dial
    if {$dir == "L"} {
        set dial_pos [expr {($dial_pos - $amount) % 100}]
    } elseif {$dir == "R"} {
        set dial_pos [expr {($dial_pos + $amount) % 100}]
    }

    # Did we land on zero?
    if {$dial_pos == 0} {
        incr times_at_zero
    }
}

puts "Part1 answer: $times_at_zero"

