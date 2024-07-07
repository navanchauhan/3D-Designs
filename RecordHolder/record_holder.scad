// Record Holder
// Tested with 2 Large 3M Picture Hanging Command Strips

// Variables 
// 1 unit = 1 mm 
length = 190;           // 2x command strips
back_height = 20;       // Side facing the wall
radius = back_height;
thickness = 6;

$fn = $preview ? 10 : 100;

rotate([0,0,180]) {

// Main Body
cube([length, 10, 20]);

// Base Layer
cube([length, radius + 2 * thickness, thickness]);

// Middle Layer
translate([0, radius + 2 * thickness, 0]) {
    cube([length, 3.2, thickness + 6.4]);
}

// Top Layer with Hole
translate([0, thickness, thickness]) {
    difference() {
        cube([length, radius, back_height - thickness]);
        translate([0, radius, radius]) {
            rotate([0, 90, 0]) {
                cylinder(h = length, r = radius, center = false);
            }
        }
    }
}

}