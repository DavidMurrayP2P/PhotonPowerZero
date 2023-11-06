union () {
difference(){
union(){
translate([-3,0,2.4])cube([98,97,7], center=true);    
translate([-13,-6.5,19.5])cube([78,62,31], center=true); 
translate([-23.5,-6.5,19.5])cube([8,69,31], center=true);

}
    //Cube LiPo Battery
    translate([-35,-6.5,20])cube([26,52,37], center=true);
     
    //Outside rail mounts
    translate([0,50.8,-3.5])  rotate([0,90,0])   cylinder(h=115, r1=9, r2=9, center=true,$fn=128);
    translate([0,-50.8,-3.5])  rotate([0,90,0])   cylinder(h=115, r1=9, r2=9, center=true,$fn=128);

    //Hole clearance
    //translate([0,29.5,-17])  rotate([0,90,0])   cylinder(h=115, r1=17, r2=17, center=true,$fn=128);
    //translate([0,-29.5,-17])  rotate([0,90,0])   cylinder(h=115, r1=17, r2=17, center=true,$fn=128);
    
    //Cavity for camera cable
    translate([-36,0,4.5])cube([26,28,9.4], center=true);
    translate([-35.5,0,0.7])cube([26,16.3,2.4], center=true);
    translate([-12,0,3.05]) rotate([0,-12,0]) cube([25,16.3,2], center=true);

    //Camera cable routing
    translate([-37.5,28,23])  rotate([0,0,0])   cylinder(22, r1=5.5, r2=5.5, center=true,$fn=128);

    //Holes for battery terminals and solar plug
    translate([30,-30,16])cube([100,40.5,40], center=true);
    translate([30,30,16])cube([100,40.5,40], center=true);
    
    //Camera installation
    translate([-39,0,20])cube([20,32,35], center=true);
    
    //battery cable routing
    translate([-37,-37,27])  cube([7,10,20
    ], center=true);
    translate([-54,-34,12]) rotate([15,0,0])  cube([14,3,15], center=true);
    #translate([-37,-32,0])  cube([40,3,6], center=true);
    translate([-45,-37,20])rotate([0,90,0])   cylinder(h=15, r1=3, r2=3, center=true,$fn=24);
    translate([-35,-32,3])rotate([0,90,0])   cylinder(h=35, r1=3, r2=3, center=true,$fn=24);

    
    //thermistor routing
    translate([-10,-20,2])  rotate([0,90,0])   cylinder(40, r1=2.5, r2=2.5, center=true,$fn=128);
    
    //camera holes
    translate([-51,10.5,30.7])rotate([0,90,0])   cylinder(h=5, r1=1.2, r2=1.2, center=true,$fn=24);
    translate([-51,-10.5,30.7])rotate([0,90,0])   cylinder(h=5, r1=1.2, r2=1.2, center=true,$fn=24);
    translate([-51,10.5,18.2])rotate([0,90,0])   cylinder(h=5, r1=1.2, r2=1.2, center=true,$fn=24);
    translate([-51,-10.5,18.2])rotate([0,90,0])   cylinder(h=5, r1=1.2, r2=1.2, center=true,$fn=24);

    //camera cutout
    #translate([-52,0,23])cube([8,13,20], center=true);
    
     //Pi Zero holes  
    translate([-17,-35.7,31])rotate([0,90,0])   cylinder(h=20, r1=1.7, r2=1.7, center=true,$fn=24);
    translate([-17,22.3,31])rotate([0,90,0])   cylinder(h=20, r1=1.7, r2=1.7, center=true,$fn=24);
    translate([-17,-35.7,8])rotate([0,90,0])   cylinder(h=20, r1=1.7, r2=1.7, center=true,$fn=24);
    translate([-17,22.3,8])rotate([0,90,0])   cylinder(h=20, r1=1.7, r2=1.7, center=true,$fn=24);
    
    //Pi 4 cutout 85.6mm × 56.5mm
    //translate([52,0.8,25])cube([58,87,30], center=true);
    //Pi Zero cut out 65mm x 30mm
    //translate([6,-9,22])cube([42,120,33], center=true);
    
    //Pi PCB cutout
    translate([16,-6.5,20])cube([72,70.5,36], center=true);
    translate([5,-6.5,35])cube([60,52,15], center=true);

    //Ventilation
    
    translate([-44,-6.5,20])rotate([90,0,0])   cylinder(h=88, r1=2, r2=2, center=true,$fn=24);
    translate([-30,0,20])rotate([90,0,0])   cylinder(h=88, r1=2, r2=2, center=true,$fn=24);    
    translate([-44,-6.5,10])rotate([90,0,0])   cylinder(h=88, r1=2, r2=2, center=true,$fn=24);
    translate([-30,0,10])rotate([90,0,0])   cylinder(h=88, r1=2, r2=2, center=true,$fn=24);    
    translate([-44,-6.5,30])rotate([90,0,0])   cylinder(h=88, r1=2, r2=2, center=true,$fn=24);
    translate([-30,0,30])rotate([90,0,0])   cylinder(h=88, r1=2, r2=2, center=true,$fn=24);    



}
//Camera cable routing
translate([-37.5,26,15])  rotate([0,0,0])   cylinder(30, r1=2.3, r2=2.3, center=true,$fn=128);
        }

