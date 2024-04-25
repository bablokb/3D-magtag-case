// -----------------------------------------------------------------------------
// 3D-Model (OpenSCAD) case for Adafruit MagTag
//
// Author: Bernhard Bablok
// License: CC BY-SA 4.0
//
// https://github.com/bablokb/3D-magtag-case
// ---------------------------------------------------------------------------

include <dimensions.scad>
include <BOSL2/std.scad>

h_sup = b;                            // height screw support
h_case = b + h_sup + zsize + z_pcb;   // base-plate + screws + height of standoffs
x_off = x_pcb/2-r_pcb;
y_off = y_pcb/2-r_pcb;

st3_off = 18.5;
st3_x   = 9.8;
st3_z   = 5.7;
qt_x    = 6.3;
qt_z    = 3.1;

usbc_off = 8.4;
usbc_y   = 9.2;
usbc_z   = 3.5;

reset_off = 22.3;
reset_y   = 7.5;
reset_z   = 3.6;

boot_off  = 34.2;
boot_y    = 7.5;
boot_z    = 3.6;

// --- corpus   --------------------------------------------------------------

module corpus() {
  x_sup_off = x_pcb/2-r_pcb;
  y_sup_off = y_pcb/2-r_pcb;
  
  // base plate
  cuboid([xsize+2*w4,ysize+2*w4,b],anchor=BOTTOM+CENTER,
            rounding=r_pcb,edges="Z");
  
  // screw supports
  move([-x_off,+y_off,b-fuzz]) cyl(h=h_sup,d=1.2*d_head,anchor=BOTTOM+CENTER);
  move([-x_off,-y_off,b-fuzz]) cyl(h=h_sup,d=1.2*d_head,anchor=BOTTOM+CENTER);
  move([+x_off,+y_off,b-fuzz]) cyl(h=h_sup,d=1.2*d_head,anchor=BOTTOM+CENTER);
  move([+x_off,-y_off,b-fuzz]) cyl(h=h_sup,d=1.2*d_head,anchor=BOTTOM+CENTER);

  // walls
  rect_tube(isize=[xsize,ysize],wall=w4,h=h_case,anchor=BOTTOM+CENTER,
            rounding=r_pcb,irounding=r_pcb);
}

// --- case (corpus with cutouts)   ------------------------------------------

module case() {
  difference() {
    corpus();

    // cutout screw-holes
    move([-x_off,+y_off,-fuzz]) cyl(h=b,d=d_head,anchor=BOTTOM+CENTER);
    move([-x_off,-y_off,-fuzz]) cyl(h=b,d=d_head,anchor=BOTTOM+CENTER);
    move([+x_off,+y_off,-fuzz]) cyl(h=b,d=d_head,anchor=BOTTOM+CENTER);
    move([+x_off,-y_off,-fuzz]) cyl(h=b,d=d_head,anchor=BOTTOM+CENTER);

    move([-x_off,+y_off,-fuzz]) cyl(h=2*b+2*fuzz,d=d_screw,anchor=BOTTOM+CENTER);
    move([-x_off,-y_off,-fuzz]) cyl(h=2*b+2*fuzz,d=d_screw,anchor=BOTTOM+CENTER);
    move([+x_off,+y_off,-fuzz]) cyl(h=2*b+2*fuzz,d=d_screw,anchor=BOTTOM+CENTER);
    move([+x_off,-y_off,-fuzz]) cyl(h=2*b+2*fuzz,d=d_screw,anchor=BOTTOM+CENTER);

    // cutouts bottom (Stemma)
    move([-xsize/2+st3_x/2+st3_off,-ysize/2,h_case-z_pcb]) cuboid([st3_x,2*w4+fuzz,st3_z],anchor=TOP+CENTER);
    move([0,-ysize/2,h_case-z_pcb]) cuboid([qt_x,2*w4+fuzz,qt_z],anchor=TOP+CENTER);
    move([+xsize/2-st3_x/2-st3_off,-ysize/2,h_case-z_pcb]) cuboid([st3_x,2*w4+fuzz,st3_z],anchor=TOP+CENTER);

    // cutouts right (buttons, USB-C)
    move([+xsize/2,-ysize/2+usbc_y/2+usbc_off,h_case-z_pcb]) cuboid([2*w4+fuzz,usbc_y,usbc_z],anchor=TOP+CENTER);
    move([+xsize/2,-ysize/2+reset_y/2+reset_off,h_case-z_pcb]) cuboid([2*w4+fuzz,reset_y,usbc_z],anchor=TOP+CENTER);
    move([+xsize/2,-ysize/2+boot_y/2+boot_off,h_case-z_pcb]) cuboid([2*w4+fuzz,boot_y,usbc_z],anchor=TOP+CENTER);
  }
}

// --- top-level object   ----------------------------------------------------

case();
