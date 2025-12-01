# Advent of Code 2025.  
# Day 01:  Secret Entrance
# Part 2:  Password method 0x434C49434B (click)
#          Number of times the dial points to position zero, even if it doesn't land on it..


source ../aoc_library.tcl

# set data [exec cat demo.txt]
set data [exec cat input.txt]

set dial_pos 50
set times_at_zero 0

foreach move $data {
    set dir     [string index $move 0]
    set amount  [string range $move 1 end]

    # Calculate full rotations
    set rotations [expr {$amount / 100}]
    incr times_at_zero $rotations


    # Move the dial.
    set old_dial_pos $dial_pos
    if {$dir == "L"} {
        set dial_pos [expr {($old_dial_pos - $amount) % 100}]
    } elseif {$dir == "R"} {
        set dial_pos [expr {($old_dial_pos + $amount) % 100}]
    }

    # Four possibilities to consider:
    #   - start at zero 
    #   - end at zero
    #   - cross zero going left
    #   - cross zero going right
    if {$old_dial_pos == 0} {
        continue
    } elseif {$dial_pos == 0} {
        incr times_at_zero
    } elseif {$dir == "L" && $dial_pos > $old_dial_pos} {
        incr times_at_zero
    } elseif {$dir == "R" && $dial_pos < $old_dial_pos} {
        incr times_at_zero
    }
}

puts "Part2 answer: $times_at_zero"

