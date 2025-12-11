# Advent of Code 2025.  
# Day 04: Printing Department 
# Part 1:  How many rolls can be accessed by a forklift.
#          A forklift can access a roll of paper from a position if fewer
#          than 4 rolls of paper are adjacent to it.

source ../aoc_library.tcl

set data [exec cat demo.txt]
# set data [exec cat input.txt]

set grid [make_grid_from_lines $data]
print_grid $grid
puts ""

set num_rows [llength $grid]
set num_cols [llength [lindex $grid 0]]

# Initialize another list of lists to all zeros.  This will hold counts of adjacent rolls.
set counts [regsub -all {[.@]} $grid 0]

# Scan the grid for rolls and increment adjacent counts.
set deltas [list {-1 -1} {-1 0} {-1 1} {0 -1} {0 1} {1 -1} {1 0} {1 1}]
foreach r [range 0 $num_rows-1] {
    foreach c [range 0 $num_cols-1] {

        # If this r,c position is a roll, then increment the counts in adjacent positions.
        set char [lindex $grid $r $c]
        if {$char eq "@"} {
            foreach delta $deltas {
                lassign $delta dr dc
                set rr [expr {$r + $dr}]
                set cc [expr {$c + $dc}]
                set prev_count [lindex $counts $rr $cc]
                if {$prev_count ne ""} {
                    lset counts $rr $cc [expr {$prev_count + 1}]
                }
            }
        }
    }
}
print_grid $counts

# Now check each roll's count.
set total 0
set grid_copy $grid
foreach r [range 0 $num_rows-1] {
    foreach c [range 0 $num_cols-1] {

        # If this r,c position is a roll, then check if at least one neighbor is less than 4.
        set char [lindex $grid $r $c]
        if {$char eq "@" && [lindex $counts $r $c] < 4} {
            puts "Yes:  ($r,$c) = $adjacent_count"
            incr total
            lset grid_copy $r $c x 
        }
    }
}

print_grid $grid_copy
puts "Part 1 answer: $total"
