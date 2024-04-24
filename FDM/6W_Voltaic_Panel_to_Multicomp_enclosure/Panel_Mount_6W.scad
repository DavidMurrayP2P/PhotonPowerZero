//Mount to the solar pannel
difference(){
union(){
    translate([0,0,2])cube([176,220.5,3.5],center=true,$fn=24);
    translate([0,0,3.8])cube([102,128,6],center=true,$fn=24);
    translate([46.5, -59.5, 27])cube([9,9,50.5], center=true,$fn=24);
    translate([-46.5, -59.5, 27])cube([9,9,50.5], center=true,$fn=24);
    translate([46.5, 59.5, 27])cube([9,9,50.5], center=true,$fn=24);
    translate([-46.5, 59.5, 27])cube([9,9,50.5], center=true,$fn=24);
   
    translate([0,59.5, 27])cube([9,9,50.5], center=true,$fn=24);
    translate([0, -59.5, 27])cube([9,9,50.5], center=true,$fn=24); 
}

    //subtracting from the bottom plate    
    translate([0,0,2])cube([80,105,10],center=true,$fn=24);

    translate([-67.5,0,2])cube([33,190,10],center=true,$fn=24);
    translate([67,0,2])cube([32,122,10],center=true,$fn=24);

    translate([66,82,2])cube([33,27,10],center=true,$fn=24);
    translate([66,-82,2])cube([33,27,10],center=true,$fn=24);

    translate([22.5,84,2])cube([35,40,10],center=true,$fn=24);
    translate([-22.5,-84,2])cube([35,40,10],center=true,$fn=24);
    translate([22.5,-84,2])cube([35,40,10],center=true,$fn=24);
    translate([-22.5,84,2])cube([35,40,10],center=true,$fn=24);
    
    //Cutouts for pannel screws
    translate([-80.7, -103.7, 1])cylinder(h=5, r=3.2, center=true,$fn=24);
    translate([80.7, -103.7, 1])cylinder(h=5, r=3.2, center=true,$fn=24);
    translate([-80.7, -103.7, 4])cylinder(h=5, r=5.7, center=true,$fn=24);
    translate([80.7, -103.7, 4])cylinder(h=5, r=5.7, center=true,$fn=24);
    
    //Cutouts for pannel screws
    translate([-80.7, 103.7, 1])cylinder(h=5, r=3.2, center=true,$fn=24);
    translate([80.7, 103.7, 1])cylinder(h=5, r=3.2, center=true,$fn=24);
    translate([-80.7, 103.7, 4])cylinder(h=5, r=5.7, center=true,$fn=24);
    translate([80.7, 103.7, 4])cylinder(h=5, r=5.7, center=true,$fn=24);
    
    translate([46.5, 59.5, 0])cylinder(h=7, r=2.7, center=true,$fn=24);
    translate([-46.5, -59.5, 0])cylinder(h=7, r=2.7, center=true,$fn=24);
    translate([-46.5, 59.5,0])cylinder(h=7, r=2.7, center=true,$fn=24);
    translate([46.5, -59.5, 0])cylinder(h=7, r=2.7, center=true,$fn=24);
    translate([0, 59.5,0])cylinder(h=7, r=2.7, center=true,$fn=24);
    translate([0, -59.5, 0])cylinder(h=7, r=2.7, center=true,$fn=24);

    translate([46.5, 59.5, 15])cylinder(h=100, r=1.8, center=true,$fn=24);
    translate([-46.5, 59.5, 15])cylinder(h=100, r=1.8, center=true,$fn=24);
    translate([46.5, -59.5, 15])cylinder(h=100, r=1.8, center=true,$fn=24);
    translate([-46.5, -59.5, 15])cylinder(h=100, r=1.8, center=true,$fn=24);
    translate([0, -59.5, 15])cylinder(h=100, r=1.8, center=true,$fn=24);
    translate([-0, 59.5, 15])cylinder(h=100, r=1.8, center=true,$fn=24);
    
    //Air flow
    translate([-33,0,9])  rotate([90,0,0])   cylinder(h=140, r=7, center=true,$fn=128);
    translate([33,0,9])  rotate([90,0,0])   cylinder(h=140, r=7, center=true,$fn=128);
    
    translate([-13,0,9])  rotate([90,0,0])   cylinder(h=140, r=7, center=true,$fn=128);
    translate([13,0,9])  rotate([90,0,0])   cylinder(h=140, r=7, center=true,$fn=128);
    
    translate([0,48,9])  rotate([0,90,0])   cylinder(h=140, r=7, center=true,$fn=128);
    translate([0,-48,9])  rotate([0,90,0])   cylinder(h=140, r=7, center=true,$fn=128);
    
    translate([0,12,9])  rotate([0,90,0])   cylinder(h=140, r=7, center=true,$fn=128);
    translate([0,-12,9])  rotate([0,90,0])   cylinder(h=140, r=7, center=true,$fn=128);
    
    translate([0,30,9])  rotate([0,90,0])   cylinder(h=140, r=7, center=true,$fn=128);
    translate([0,-30 ,9])  rotate([0,90,0])   cylinder(h=140, r=7, center=true,$fn=128);


    
    
    
    
    
}

//Pole mount
translate([0,0,52])difference(){ 


difference(){
union(){
cube([102,128,4],center=true);
translate([0,0,20])cylinder(h=40, r1=50, r2=27, center=true,$fn=128);
}
    translate([46.5, 59.5, -25])cylinder(h=100, r=1.8, center=true,$fn=24);
    translate([-46.5, -59.5, -25])cylinder(h=100, r=1.8, center=true,$fn=24);
    translate([-46.5, 59.5, -25])cylinder(h=100, r=1.8, center=true,$fn=24);
    translate([46.5, -59.5, -25])cylinder(h=100, r=1.8, center=true,$fn=24);
    translate([0, 59.5, -25])cylinder(h=100, r=1.8, center=true,$fn=24);
    translate([0, -59.5, -25])cylinder(h=100, r=1.8, center=true,$fn=24);
   
    translate([46.5, 59.5, 1])cylinder(h=3.2, r=3.2, center=true,$fn=24);
    translate([-46.5, -59.5, 1])cylinder(h=3.2, r=3.2, center=true,$fn=24);
    translate([-46.5, 59.5,1])cylinder(h=3.2, r=3.2, center=true,$fn=24);
    translate([46.5, -59.5, 1])cylinder(h=3.2, r=3.2, center=true,$fn=24);
    translate([0, 59.5,1])cylinder(h=3.2, r=3.2, center=true,$fn=24);
    translate([0, -59.5, 1])cylinder(h=3.2, r=3.2, center=true,$fn=24);

    //pole mount holes
    translate([0,0,25])cylinder(h=60, r=22.5, center=true,$fn=128); //Adjust this for different pole sizes
    

    translate([0,0,25])rotate([90,0,25])   cylinder(h=100, r1=2, r2=2, center=true,$fn=124);
    translate([0,0,10])rotate([90,0,-25])   cylinder(h=100, r1=2, r2=2, center=true,$fn=124);
    translate([0,0,10])rotate([0,90,115])   cylinder(h=100, r1=2, r2=2, center=true,$fn=124);
    translate([0,0,25])rotate([0,90,-115])   cylinder(h=100, r1=2, r2=2, center=true,$fn=124);
    
    translate([0,0,25])rotate([90,0,25])   cylinder(h=100, r1=2, r2=2, center=true,$fn=124);
    translate([0,0,10])rotate([90,0,-25])   cylinder(h=100, r1=2, r2=2, center=true,$fn=124);
    translate([0,0,10])rotate([0,90,115])   cylinder(h=100, r1=2, r2=2, center=true,$fn=124);
    translate([0,0,25])rotate([0,90,-115])   cylinder(h=100, r1=2, r2=2, center=true,$fn=124);

    translate([14.5,-31,25])rotate([90,0,25])   cylinder(h=7.9, r=4.5, center=true,$fn=124);
    translate([-18.5,-38.3,10])rotate([90,0,-25])   cylinder(h=10, r=4.5, center=true,$fn=124);
    translate([18,-38.3,10])rotate([0,90,115])   cylinder(h=10, r=4.5, center=true,$fn=124);
    translate([-14.5,-31,25])rotate([0,90,-115])   cylinder(h=7.9, r=4.5, center=true,$fn=124);
    
    translate([-14.5,31,25])rotate([90,0,25])   cylinder(h=7.9, r=4.5, center=true,$fn=124);
    translate([18.5,38.3,10])rotate([90,0,-25])   cylinder(h=10, r=4.5, center=true,$fn=124);
    translate([-18,38.3,10])rotate([0,90,115])   cylinder(h=10, r=4.5, center=true,$fn=124);
    translate([14.5,31,25])rotate([0,90,-115])   cylinder(h=7.9, r=4.5, center=true,$fn=124);

    
    translate([-60, 0, 10])cube([65,110,70],center=true);
    translate([60, 0, 10])cube([65,110,70],center=true);
         

}
}


