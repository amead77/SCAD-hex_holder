
//Dimension X
base_x = 100;
//Dimension Y
base_y = 50;
//Dimension Z (height)
base_z = 12;
//how many holes in the X dimension
columns = 8;
//how many holes in the Y dimension
rows = 4;
//depth of holes
depth = 10;
//distance from edges (0 for default spacing)
edge = 0;

module __Customizer_Limit__ () {}  // This actually works

run = 1;
//hex_depth = base_z - 1 + 0.01; //0.01 is just to make the 3d viewer show the hole correctly
hex_size = 7.15;
hex_spacing_x = base_x / (columns+1);
hex_spacing_y = base_y / (rows+1);



if(run == 1) {
    difference() {
        create_base();
        create_hex();
    } 
} else if (run == 2) {
    create_hex();
}

module create_base() {
    cube([base_x, base_y, base_z]);
}

module hex(hdepth) {
    $fn = 6;
    echo("hex:", hdepth)
    let (edge_space = (edge == 0) ? hex_spacing_x : edge) {
        //echo("e:", (edge > 0 ? edge : hex_spacing_x));
        echo("edge:", edge_space);
        for (x = [0:1:columns-1]) {
            for (y = [0:1:rows-1]) {
                translate([(hex_spacing_x*x)+hex_spacing_x, (hex_spacing_y*y)+hex_spacing_y, (base_z-hdepth)+0.01]) 
                    cylinder(h = hdepth, r = hex_size / 2);
            }
        }
    }
}

module create_hex() {
    if (depth > (base_z - 1 + 0.01)) {
        let (hex_depth = base_z - 1 + 0.01) {
            echo("a:", hex_depth);
            hex(hex_depth);
        }
    } else {
        let (hex_depth = depth) {
            echo("b:", hex_depth);
            hex(hex_depth);
        }
    }
}