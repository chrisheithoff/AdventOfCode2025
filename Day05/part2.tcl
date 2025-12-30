# Advent of Code 2025.  
# Day 05: Cafeteria
# Part 2:  How many possible ingredient ID's would be fresh?

source ../aoc_library.tcl

# set data [file_to_list_of_lists "demo.txt"]
set data [file_to_list_of_lists "input.txt"]

set ranges  [lindex $data 0]

# Sort the ranges first by their first value
set ranges [lsort -dictionary $ranges]
set nums_in_ranges [list]

foreach range $ranges {
    puts "Processing range: $range"
    foreach {min max} [split $range "-"] {
        puts "   min: $min max: $max"
        for {set i $min} {$i <= $max} {incr i} {
            lappend nums_in_ranges $i
        }
    }
}
 set nums_in_ranges [lsort -unique -integer $nums_in_ranges]
 puts "Total numbers in ranges: [llength $nums_in_ranges]"

# Compress the list of ranges into mutually exclusive ranges
# e.g. 1-3,2-4 becomes 1-4
set compressed_ranges [lindex $ranges 0]
foreach range [lrange $ranges 1 end] {
    puts "Processing range: $range"
    lassign [split $range "-"] start stop

    set last_range [lindex $compressed_ranges end]
    lassign [split $last_range "-"] last_start last_stop

    if {$start <= $last_stop + 1} {
        # Overlaps or touches, so update the last range.
        if {$stop > $last_stop} {
            set new_last_range "$last_start-$stop"
            lset compressed_ranges end $new_last_range
        }
    } else {
        # No overlap, add as new range
        lappend compressed_ranges $range
    }
}

# Count the total number of fresh IDs in the compressed ranges
set total_fresh 0
foreach range $compressed_ranges {
    lassign [split $range "-"] start stop
    incr total_fresh [expr {$stop - $start + 1}]
}

puts "Part 2 answer: $total_fresh" 
