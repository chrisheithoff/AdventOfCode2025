# Advent of Code 2025.  
# Day 02:  Gift Shop
# Part 1:  Find the sum of all invalid product IDs

source ../aoc_library.tcl

set data [exec cat demo.txt]
# set data [exec cat input.txt]

# An invalid product ID is defined as two numbers repeated, like 99, 1212, or 4545.
proc is_invalid {id} {
    return [regexp {^(\d+)\1$} $id]
}

set sum_of_invalid_ids 0

foreach range [split $data ","] {
    lassign [split $range "-"] min max
    puts "Checking range $min to $max"

    for {set n $min} {$n <= $max} {incr n} {
        if {[is_invalid $n]} {
            puts "  Invalid ID: $n"
            incr sum_of_invalid_ids $n
        }
    }
}

puts "Part1 answer: $sum_of_invalid_ids"

