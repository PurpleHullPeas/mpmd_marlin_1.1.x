#!/bin/sh

ZD=contents/setup_gcode

mkdir -p "$ZD"


cat <<EOF >"$ZD/AUTO_CALIBRATE.gcode"
M988 calibrat.txt
M115
M851 Z0
G28
G33 V3 T
G29 V3
M851 Z0.600
M500
M503
M503 S0
M989
M73 P100#
M118 {E\:Done! (see calibrat.txt)}#
EOF

cat <<EOF >"$ZD/CREATE_FCUPDATE.gcode"
M28 /fcupdate.flg
M29
M73 P100#
M118 {E\:CREATED fcupdate.flg}#
EOF

cat <<EOF >"$ZD/DELETE_FCUPDATE.gcode"
M30 /fcupdate.flg
M73 P100#
M118 {E\:DELETED fcupdate.flg}#
EOF

cat <<EOF >"$ZD/FILAMENT_LOAD.gcode"
; yet to be implemented
M73 P100#
M118 {E\:OOPS! Not Implemented.}
EOF

cat <<EOF >"$ZD/FILAMENT_UNLOAD.gcode"
; yet to be implement
M73 P100#
M118 {E\:OOPS! Not Implemented.}
EOF

cat <<EOF >"$ZD/G0_X0_Y0_Z0.gcode"
G0 X0 Y0 F4000
G0 Z8 F4000
G0 Z0 F800
EOF

cat <<EOF >"$ZD/G28_HOME.gcode"
G28
EOF

cat <<EOF >"$ZD/G29_BED_LEVEL.gcode"
M988 bedlevel.txt
G28
G29 V1
M500
M503 S0
M989
M73 P100#
M118 {E\:Done! (see bedlevel.txt)}#
EOF

cat <<EOF >"$ZD/M500_SAVE.gcode"
M500
M118 {E\:SAVED current settings}#
EOF

cat <<EOF >"$ZD/M501_RESTORE.gcode"
M501
M73 P100#
M118 {E\:loaded STORED settings}#
EOF

cat <<EOF >"$ZD/M502_FACTORY.gcode"
M502
M73 P100#
M118 {E\:loaded FACTORY settings}#
EOF

cat <<EOF >"$ZD/M503_REPORT.gcode"
M988 settings.txt
M115
M503
M989
M73 P100#
M118 {E\:Done! (see settings.txt)}#
EOF

for zo in 000 300 350 400 450 500 550 600 650 700 750 800
do
    cat <<EOF >"$ZD/M851_Z${zo}.gcode"
M851 Z0.${zo}
M73 P100#
M118 {E\:M851 Z0.${zo}}#
EOF
done