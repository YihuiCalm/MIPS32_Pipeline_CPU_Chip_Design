create_library_set -name CommonTiming\
   -timing\
    [list innovus/osu05_stdcells_expanded.tlf\
    innovus/osu05_stdcells.tlf]
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
    [list /home/ead/yihui/ece6250/MIPS32_Pipeline_CPU_Chip_Design/src/syn/MIPS32_CPU_top_syn.sdc]
create_analysis_view -name view_hold -constraint_mode TimingConstraints -delay_corner corner_min
set_analysis_view -setup [list view_hold] -hold [list view_hold]
