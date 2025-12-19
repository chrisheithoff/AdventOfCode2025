# Advent of Code 2025.  
# Day 05: Cafeteria
# Part 1:  How many of the available fresh IDs are fresh?

source ../aoc_library.tcl

set data [file_to_list_of_lists "demo.txt"]
set data [file_to_list_of_lists "input.txt"]

set ranges  [lindex $data 0]
set ids     [lindex $data 1]

proc is_fresh {id ranges} {
    foreach range $ranges {
        set parts [split $range "-"]
        set start [lindex $parts 0]
        set stop  [lindex $parts 1]

        if {$id >= $start && $id <= $stop} {
            return 1
        }
    }
    return 0
}

set fresh_count 0
foreach id $ids {
    if {[is_fresh $id $ranges]} {
        incr fresh_count
        continue
    }
}

puts "Part 1 answer: $fresh_count"
