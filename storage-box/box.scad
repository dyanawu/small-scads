include <MCAD/shapes/3Dshapes.scad>
include <MCAD/array/rectangular.scad>
include <MCAD/units/metric.scad>

x = 55;
y = 47;
z = 27;

rd = 3;
wt = 1.4;

mult = 0.33;
hx = x * mult;
hy = y * mult;
hz = wt + (epsilon * 2);
hrd = rd;// * (1 - mult);

$fa = 1;
$fs = 0.1;

module outer() {
   mcad_rounded_cube([x, y, z], rd + wt, true, X + Y);
}

module inner() {
    translate(Z * wt)
        mcad_rounded_cube([x-(wt*2), y-(wt*2), z-wt+epsilon], rd, true, X + Y);
}

module hole() {
    translate(Z*-epsilon)
        mcad_rounded_cube([hx, hy, hz], hrd, true, X + Y);
}

module hole_grid() {
  nx = 2;
  ny = 2;
  
  sep_x = hx + ((x - (hx * nx)) / (nx + 1));
  sep_y = hy + ((y - (hy * ny)) / (ny + 1));
  mcad_array_rectangular([nx, ny], [sep_x, sep_y]) hole();
}

module box() {
    difference() {
        outer();
        inner();
        hole_grid();
    }
}

box();