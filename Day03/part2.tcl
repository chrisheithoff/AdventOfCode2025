# Advent of Code 2025.  
# Day 03:  Lobby
# Part 2:  Find maximum possible joltage from all the battery banks.
#          but now the joltage is the largest 12-digit number that can be formed, left-to-right.

source ../aoc_library.tcl

# set data [exec cat demo.txt]
set data [exec cat input.txt]

# The joltage of a bank is the largest 12-digit number that can be
#  formed, reading from left to right.
proc get_joltage {bank digits} {
    set joltage ""

    set remaining_digits $digits
    while {$remaining_digits > 0} {
        # The next digit is the largest digit that can be chosen
        #   - there must be enough digits to complete a 12-digit number.
        set N         [expr {$remaining_digits - 1}]
        set range     [lrange $bank 0 end-$N]
        set max       [tcl::mathfunc::max {*}$range]
        append joltage $max

        # Remove all digits up to and including the chosen digit.
        set max_index [lsearch $bank $max]
        set bank      [lrange $bank $max_index+1 end] 
        incr remaining_digits -1

        # If possible, just append the rest of the digits in order 
        #  instead of continuing one digit at a time.
        if {[llength $bank] == $remaining_digits} {
            append joltage [join $bank ""]
            break
        }
    }
    return $joltage
}


set max_joltage 0
foreach bank $data {
    set bank [split $bank ""]
    set joltage [get_joltage $bank 12]
    puts $joltage
    incr max_joltage $joltage
}

puts "Part2 answer: $max_joltage"


