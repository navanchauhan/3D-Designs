$fn = 100;

/*
Can holder MTB

Tested w/ Giant Talon 2 (2022) and Marin Drift Zone 1

Infill: 40%
*/

/*

Type: can_height_offset / base_width / base_depth_offset

Normal 12oz can: 122 / 20 / 0
Keystone 12oz: 133
Yerba Mate: 15.5 oz
Red Bull: 8.4oz: 136 / 15 / -6.5

*/

can_height_offset = 122;
base_width = 20;
base_depth_offset = 0; // For Non-12oz Cans

can_height = can_height_offset + 8; // 12.cm
base_depth = 10;                    // 1cm
screw_small_depth = 3;
screw_thread_diameter = 9;
bolt_head_diameter = 12;                        // 6mm for M5 bolt
dist_between_holes = 55;                        // 2.14inch / 64mm
hole_offset = 25;                               // 2cm from origin
bottom_lip_height = 4.5;                        // 4.5mm 2cm (1cm + xyz)
bottom_lip_thickness = 5;                       // 5mm
bottom_lip_base = 5;                            // 10mm
bottom_lip_extrusion = 12.5 + base_depth - 6.5; // 10.5mm
upper_lip_base = 5;
upper_lip_thickness = 23 + base_depth - 6.5; // height basically
upper_pushness_thickness = 4;
upper_pusher_base = 15;
upper_can_hook_height = 10;
upper_can_hook_base = 5;
upper_can_hook_width = 5;
upper_hook_radius = 10;
upper_lip_difference = 2.50;

/*
translate([-20,120,base_depth-2]) {
rotate([64,0,20]){
color([1,0,0]) {
import("soda_can.stl");
}
}
}
*/

module
pieSlice(a, r, h)
{
    // a:angle, r:radius, h:height
    rotate_extrude(angle = a) square([ r, h ]);
}

// Base w/ Screw Holes
linear_extrude(base_depth)
{
    difference()
    {
        difference()
        {
            square([ base_width, can_height ]);
            translate([ base_width / 2, hole_offset, 0 ])
            {
                circle(d = bolt_head_diameter);
                translate([ 0, (bolt_head_diameter) + dist_between_holes, 0 ])
                {
                    circle(d = bolt_head_diameter);
                }
            }
        }
    }
}

// Screw Hole Padding
linear_extrude(screw_small_depth)
{
    translate([ base_width / 2, hole_offset, 0 ])
    {
        difference()
        {
            circle(d = bolt_head_diameter);
            circle(d = screw_thread_diameter);
        }
        translate([ 0, (bolt_head_diameter) + dist_between_holes, 0 ])
        {
            difference()
            {
                circle(d = bolt_head_diameter);
                circle(d = screw_thread_diameter);
            }
        }
    }
}

// Upper Hook
difference()
{
    linear_extrude(upper_lip_thickness)
    {
        translate([ 0, -upper_lip_base, 0 ])
        {
            square([ base_width, upper_lip_base ]);
        }
    }

    translate([ -2.5, -upper_lip_difference, base_depth / 2.5 ])
    {
        linear_extrude(upper_lip_thickness - 10 - (base_depth / 2.5))
        {
            square([ base_width + 5, upper_lip_difference ]);
        }
    }
}

// Upper Hook Push Lip
translate([ 0, 0, (upper_lip_thickness * 7 / 8) - upper_pushness_thickness ])
{
    linear_extrude(upper_pushness_thickness)
    {
        translate([ 0, -upper_pusher_base - upper_lip_base, 0 ])
        {
            square([ base_width, upper_pusher_base ]);
        }
    }
}

// Upper Hook - Curved Hook
translate([ base_width, 0, upper_lip_thickness - 10 ])
{
    rotate([ 0, -90, 0 ])
    {
        pieSlice(90 + 25, upper_hook_radius, base_width);
    }
}

// Bottom Lip

linear_extrude((bottom_lip_extrusion) + bottom_lip_thickness)
{
    translate([ 0, can_height, 0 ])
    {
        square([ base_width, bottom_lip_base ]);
    }
}

translate([ 0, can_height - bottom_lip_height, (bottom_lip_extrusion) ])
{
    linear_extrude(bottom_lip_thickness)
    {
        square([ base_width, bottom_lip_height ]);
    }
}