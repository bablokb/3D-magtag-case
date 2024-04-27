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

layer = 0.2;
h_sup = b;                            // height screw support
h_case = b + h_sup + zsize + z_pcb;   // base-plate + screws + height of standoffs
x_off = x_pcb/2-r_pcb;
y_off = y_pcb/2-r_pcb;

st3_off = 18.5;
st3_x   = 10.8;
st3_z   = 5.7;
qt_off  = 35.8;
qt_x    = 7.5;
qt_z    = 3.6;

usbc_off = 8.4;
usbc_y   = 9.2;
usbc_z   = 3.5;

reset_off = 22.3;
reset_y   = 12.5;
reset_z   = 3.6 + z_pcb + fuzz;

boot_off  = 34.2;
boot_y    = 7.5;
boot_z    = 3.6 + z_pcb + fuzz;

on_off    = 9.5;
on_x      = 7.2;
on_z      = 2.3 + z_pcb + fuzz;

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

    // cutout screw-holes: bottom hole for screw-heads leave a small layer
    // for better printing. This layer has to be drilled after printing
    move([-x_off,+y_off,-fuzz]) cyl(h=b-layer,d=d_head,anchor=BOTTOM+CENTER);
    move([-x_off,-y_off,-fuzz]) cyl(h=b-layer,d=d_head,anchor=BOTTOM+CENTER);
    move([+x_off,+y_off,-fuzz]) cyl(h=b-layer,d=d_head,anchor=BOTTOM+CENTER);
    move([+x_off,-y_off,-fuzz]) cyl(h=b-layer,d=d_head,anchor=BOTTOM+CENTER);

    move([-x_off,+y_off,b]) cyl(h=h_sup+fuzz,d=d_screw,anchor=BOTTOM+CENTER);
    move([-x_off,-y_off,b]) cyl(h=h_sup+fuzz,d=d_screw,anchor=BOTTOM+CENTER);
    move([+x_off,+y_off,b]) cyl(h=h_sup+fuzz,d=d_screw,anchor=BOTTOM+CENTER);
    move([+x_off,-y_off,b]) cyl(h=h_sup+fuzz,d=d_screw,anchor=BOTTOM+CENTER);

    // cutouts bottom (Stemma)
    move([-x_pcb/2+st3_x/2+st3_off,-ysize/2,h_case-z_pcb]) cuboid([st3_x,2*w4+fuzz,st3_z],anchor=TOP+CENTER);
    move([-x_pcb/2+qt_x/2+qt_off,-ysize/2,h_case-z_pcb]) cuboid([qt_x,2*w4+fuzz,qt_z],anchor=TOP+CENTER);
    move([+x_pcb/2-st3_x/2-st3_off,-ysize/2,h_case-z_pcb]) cuboid([st3_x,2*w4+fuzz,st3_z],anchor=TOP+CENTER);

    // cutouts right (buttons, USB-C)
    move([+xsize/2,-ysize/2+usbc_y/2+usbc_off,h_case-z_pcb]) cuboid([2*w4+fuzz,usbc_y,usbc_z],anchor=TOP+CENTER);
    move([+xsize/2,-ysize/2+reset_y/2+reset_off,h_case+fuzz]) cuboid([2*w4+fuzz,reset_y,reset_z],anchor=TOP+CENTER);
    move([+xsize/2,-ysize/2+boot_y/2+boot_off,h_case+fuzz]) cuboid([2*w4+fuzz,boot_y,boot_z],anchor=TOP+CENTER);
    
    // cutout top (on-slider)
    move([-x_pcb/2+on_x/2+on_off,+ysize/2,h_case+fuzz]) cuboid([on_x,2*w4+fuzz,on_z],anchor=TOP+CENTER);
  }
}

// --- top-level object   ----------------------------------------------------

case();
