include <MCAD/units/metric.scad>
use <MCAD/shapes/3Dshapes.scad>
use <MCAD/array/polar.scad>

$fa = 1;
$fs = 0.1;

wall = 1.4;

// measure outside of smaller thing
s_height = 29;
s_dia = 47.3;

// measure outside of bigger thing
b_height = 9;
b_dia = 49.3;

cable_tie = 3;

module hole() {
  h = s_height + wall + (epsilon * 2);
  d = s_dia;

  cylinder(h, d = d);
}


module s_tube() {
  oh = s_height + wall;
  od = s_dia + (wall * 2);

  difference() {
    cylinder(oh, d = od);
    translate(Z * -epsilon) hole();
    rotate([0, 0, 60]) slit(wall*4, wall, s_height, 120, 3, (s_dia/2) - wall * 3);
    #tie_slot((s_dia/2 + (wall*2/3) + epsilon), s_height * 0.2, wall/3, cable_tie);

  }
}

module b_tube() {
  oh = b_height + wall;
  od = b_dia + (wall * 2);
  
  ih = b_height + epsilon;
  id = b_dia;
  
  difference() {
    cylinder(oh, d = od);
    translate(Z * wall)
      cylinder(ih, d = id);
    translate(Z * -epsilon) hole();
    slit(wall*4, wall, b_height, 120, 3, (b_dia/2) - wall * 3, wall);
    #tie_slot((b_dia/2 + (wall*2/3) + epsilon), b_height * 0.6, wall/3, cable_tie);

  }
}


module slit(l, t, h, a, c, r, u = 0) {
  s_len = l;
  s_thick = t;
  s_height = h;
  mcad_array_polar(a, c, r)
  translate([s_len, 0, (s_height/2) + u])
    #cube([s_len, s_thick, s_height], center = true);
}

module tie_slot(offset_out, offset_up, depth, height) {
translate(Z * offset_up)
  rotate_extrude() translate([offset_out, 0, 0]) square([depth, height]);
}


module assembled() {
  s_tube();
  translate(Z * s_height) b_tube();
}

assembled();