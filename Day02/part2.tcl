# Advent of Code 2025.  
# Day 02:  Gift Shop
# Part 2:  Find the sum of all invalid product IDs, but now an
#  invalid product ID is defined as two numbers repeated AT LEAST twice.
#    12341234 is invalid (1234 repeated twice)
#    121212 is invalid (12 repeated three times)
#    9999 is invalid (9 repeated four times)

source ../aoc_library.tcl

# set data [exec cat demo.txt]
set data [exec cat input.txt]

# Change the regex to use the backreference 1 or more times.
proc is_invalid {id} {
    return [regexp {^(\d+)\1+$} $id]
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

puts "Part2 answer: $sum_of_invalid_ids"

