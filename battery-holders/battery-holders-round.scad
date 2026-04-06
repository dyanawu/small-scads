include <MCAD/units/metric.scad>
include <MCAD/array/rectangular.scad>

$fa = 1;
$fs = 0.1;

/* cell sizes
  21700 (prot) + slop: 76x22
  18650 (prot) + slop: 71x19
  123 + slop: 36x18
*/

// cr123A
// cell_length = 36;
// cell_dia = 17.5;

// 21700
cell_length = 77;
cell_dia = 23.5;
wall = 1.2;

cell_count = 2;

outer_length = cell_length * .95;
outer_dia = cell_dia + wall * 2;

hole_dia = cell_dia/2;

module tube() {
    difference() {
        cylinder(outer_length, d = outer_dia);

        translate([0, 0, wall]) 
            cylinder(cell_length, d = cell_dia);
            
        translate(Z*-epsilon) cylinder(h = wall * 2, d = hole_dia);
        
    }
}


module slot() {
    tube();
}

mcad_array_rectangular([1, cell_count], outer_dia-wall) slot();
