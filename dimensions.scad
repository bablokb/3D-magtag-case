// -----------------------------------------------------------------------------
// 3D-Model (OpenSCAD) case for Adafruit MagTag: dimensions
//
// Author: Bernhard Bablok
// License: GPL3
//
// https://github.com/bablokb/pcb-pico-datalogger
// -----------------------------------------------------------------------------

$fa = 1;
$fs = 0.4;
$fn= $preview ? 32 : 128;

fuzz = 0.01;
w2 = 0.86;                 // 2 walls Prusa3D
w4 = 1.67;                 // 4 walls Prusa3D
gap = 0.2;                 // gap pcb to case

x_pcb = 81.0;              // pcb-dimensions
y_pcb = 53.4;
z_pcb = 1.6;
r_pcb = 4.0;               // corner radius
b     = 1.4;               // base thickness
zsize = 6;                 // height of brass-standoffs

xdelta = gap;
ydelta = gap;
xsize = x_pcb+2*xdelta;    // inner size
ysize = y_pcb+2*ydelta;

d_screw  = 3.0 + gap;      // diameter screw
d_head   = 4.8 + gap;      // diameter screw-head

