include <MCAD/units/metric.scad>
use <MCAD/shapes/2Dshapes.scad>
use <MCAD/shapes/3Dshapes.scad>


$fs = 0.4;
$fa = 1;

plaque_text = "BOB";

thickness = 2;
length = 90;
depth = 40;

rim_thickness = 3;
rim_width = 3;

text_scale = [0.8, 0.8];
text_offset = [1.5, 0];
font = "Gunplay:style=Regular";

hole_size = [10, 10];
hole_width = 3;
hole_offset = [4, -5];

rounding_r = 4;

module place_boltsnap_hole()
{
    translate([-length / 2, depth / 2] + hole_offset)
        children();
}

module boltsnap_hole()
{
    place_boltsnap_hole()
        ellipse(hole_size[0], hole_size[1]);
}

module plaque()
{
    offset(r=-rounding_r)
    offset(r=rounding_r)
    union() {
        mcad_rounded_square(
            [length, depth, thickness],
            rounding_r,
            center=true
        );

        place_boltsnap_hole()
            ellipse(hole_size[0] + hole_width*2, hole_size[1] + hole_width*2);
    }
}

module plaque_rim()
{
    difference() {
        plaque();

        offset(r=-rim_width)
            plaque();
    }
}

module plaque_text()
{
    translate(text_offset)
        translate([-length/2 * text_scale[0], -depth/2 * text_scale[1]])
        resize([length * text_scale[0], depth * text_scale[1]])
        text(plaque_text, font=font);
}

linear_extrude(height=thickness)
difference() {
    plaque();

    boltsnap_hole();
    plaque_text();
}

linear_extrude(height=rim_thickness)
plaque_rim();
