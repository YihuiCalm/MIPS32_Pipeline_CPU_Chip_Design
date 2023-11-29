if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name CommonTiming\
   -timing\
    [list ${::IMEX::libVar}/lib/typ/osu05_stdcells_expanded.tlf\
    ${::IMEX::libVar}/lib/typ/osu05_stdcells.tlf]
create_rc_corner -name default_rc_corner\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0
create_delay_corner -name corner_min\
   -library_set CommonTiming
create_constraint_mode -name TimingConstraints\
   -sdc_files\
    [list ${::IMEX::libVar}/mmmc/MIPS32_CPU_top_scan.sdc]
create_analysis_view -name view_hold -constraint_mode TimingConstraints -delay_corner corner_min
set_analysis_view -setup [list view_hold] -hold [list view_hold]
