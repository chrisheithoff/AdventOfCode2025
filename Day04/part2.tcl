# Advent of Code 2025.  
# Day 04: Printing Department 
# Part 2: How many rolls of paper in total can be remove by the Elves and their forklists? 

source ../aoc_library.tcl

set data [exec cat demo.txt]
# set data [exec cat input.txt]

set grid [make_grid_from_lines $data]
print_grid $grid
puts ""


# Return a list of lists with the counts of adjacent rolls per location.
proc count_rolls {grid} {
    set num_rows [llength $grid]
    set num_cols [llength [lindex $grid 0]]
    # Initialize to all zeros.
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
    return $counts
}

# Remove rolls that have fewer than 4 adjacent rolls
proc remove_rolls {grid} {
    set counts [count_rolls $grid]
    set num_rows [llength $grid]
    set num_cols [llength [lindex $grid 0]]
    foreach r [range 0 $num_rows-1] {
        foreach c [range 0 $num_cols-1] {

            # If this r,c position is a roll, then check if at least one neighbor is less than 4.
            set char [lindex $grid $r $c]
            if {$char eq "@" && [lindex $counts $r $c] < 4} {
                lset grid $r $c "."
            }
        }
    }
    return $grid
}


set num_start [regexp -all {@} $grid]
while {1} {
    set new_grid [remove_rolls $grid]
    if {$new_grid eq $grid} {
        break
    }
    set grid $new_grid
}
print_grid $grid
set num_end [regexp -all {@} $grid]


puts "Part 2 answer: $num_end - $num_start = [expr {$num_start - $num_end}]"
