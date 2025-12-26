include <MCAD/units/metric.scad>
use <MCAD/shapes/3Dshapes.scad>

$fa = 1;
$fs = 0.1;

wall = 1.4;

// outside of torch
t_height = 28;
t_dia = 47.5;


// inside of diffuser
d_height = 6.5;
d_dia = 40;

module hole() {
  ih = d_height + wall + (epsilon * 2);
  id = d_dia - (wall * 2);

  cylinder(ih, d = id);
}


module d_tube() {
  oh = d_height + wall;
  od = d_dia;

  ih = d_height + wall + (epsilon * 2);
  id = d_dia - (wall * 2);

  difference() {
    cylinder(oh, d = od);
    translate(Z * -epsilon) hole();
    translate(Z * (d_height * 0.56)) torus(d_dia/2 + wall * 0.4, d_dia/2 - wall * 0.4);
  }
}

module t_tube() {
  oh = t_height + wall;
  od = t_dia + (wall * 2);
  
  ih = t_height + epsilon;
  id = t_dia;
  
  difference() {
    cylinder(oh, d = od);
    translate(Z * wall)
      cylinder(ih, d = id);
    translate(Z * -epsilon) hole();
  }
}

d_tube();
translate(Z * d_height) t_tube();




