# Advent of Code 2025.  
# Day 03:  Lobby
# Part 1:  Find maximum possible joltage from all the battery banks.

source ../aoc_library.tcl

set data [exec cat demo.txt]
set data [exec cat input.txt]

# The joltage of a bank is the largest two-digit number that can be
#  formed from any two of its digits, but reading from left to right.
#  For example:
#   4135 -> 45
#   9181 -> 98
#   818912 -> 92
proc get_joltage {bank} {

    # Find the first digit of the joltage.  
    # This is the largest digit anywhere up until the second-to-last digit.
    set first [tcl::mathfunc::max {*}[lrange $bank 0 end-1]]
    set first_index [lsearch $bank $first]

    # Find the second digit of the joltage - the largest digit after the first digit.
    set second [tcl::mathfunc::max {*}[lrange $bank [expr {$first_index + 1}] end]]

    return "$first$second" 
}


set max_joltage 0
foreach bank $data {
    set bank [split $bank ""]
    incr max_joltage [get_joltage $bank]
}

puts "Part1 answer: $max_joltage"

