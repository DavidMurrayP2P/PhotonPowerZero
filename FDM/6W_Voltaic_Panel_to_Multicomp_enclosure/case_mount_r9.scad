union () {
difference(){
union(){
translate([-4,0,1.9])cube([98,98,7], center=true);    
translate([-13,-2,19.5])cube([80,79,31], center=true); 
translate([-23.5,-6.5,19.5])cube([8,69,31], center=true);
}
    //Cube LiPo Battery Core Electronics style
    translate([-34,-6.5,20])cube([26,50,35], center=true);

    //Dual cylinder lipo Adafruit style
    translate([-36,0,17.2])cube([19,68,37], center=true);
    translate([-36,0,16])cube([12,68,37], center=true);
     
    //Outside rail mounts
    translate([0,50.8,-3.7])  rotate([0,90,0])   cylinder(h=115, r1=9, r2=9, center=true,$fn=128);
    translate([0,-50.8,-3.7])  rotate([0,90,0])   cylinder(h=115, r1=9, r2=9, center=true,$fn=128);

    //Hole clearance
    //translate([0,29.5,-17])  rotate([0,90,0])   cylinder(h=115, r1=17, r2=17, center=true,$fn=128);
    //translate([0,-29.5,-17])  rotate([0,90,0])   cylinder(h=115, r1=17, r2=17, center=true,$fn=128);
    
    //Cavity for camera cable
    translate([-38,0,1])cube([23,16.3,4.6], center=true);
    translate([-33,0,0.2])cube([20,16.3,3], center=true);
    translate([-11,0,2.4]) rotate([0,-11.5,0]) cube([25,16.3,2.5], center=true);

    //Camera cable routing
    translate([-33,38,20])  rotate([0,0,0])   cylinder(27, r1=5, r2=5, center=true,$fn=128);

    //Holes for battery terminals and solar plug
    translate([30,-30,16])cube([98,40.5,40], center=true);
    translate([30,30,16])cube([98,40.5,40], center=true);
    
    //Camera installation
    translate([-41,0,20])cube([20,32,35], center=true);
    
     //battery cable routing
    translate([-34,-37,27])  cube([15,10,20], center=true);
    translate([-51.5,-38.7,9]) rotate([0,0,0])  cylinder(h=20, r1=2.1, r2=2.1, center=true,$fn=24);
    
    translate([-36,-39,0])  cube([35,1.6,4], center=true);


    //translate([-46.5,-37.5,20.7])rotate([0,90,0])   cylinder(h=12.05, r1=3.75, r2=3.75, center=true,$fn=24);
    translate([-46,-39.5,29])  cube([20,11.1,24], center=true);
   
    translate([-35,-39,0.7])rotate([0,90,0])   cylinder(h=35, r1=2, r2=2, center=true,$fn=24);

    
    ///camera holes
    translate([-51,10.5,31.5])rotate([0,90,0])   cylinder(h=5, r1=1.2, r2=1.2, center=true,$fn=24);
    translate([-51,-10.5,31.5])rotate([0,90,0])   cylinder(h=5, r1=1.2, r2=1.2, center=true,$fn=24);
    translate([-51,10.5,19])rotate([0,90,0])   cylinder(h=5, r1=1.2, r2=1.2, center=true,$fn=24);
    translate([-51,-10.5,19])rotate([0,90,0])   cylinder(h=5, r1=1.2, r2=1.2, center=true,$fn=24);

    //camera cutout
    translate([-52,0,23])cube([8,13,20], center=true);
    
     //Pi Zero holes  
    translate([-17,-35.7,31])rotate([0,90,0])   cylinder(h=17.5, r1=1.6, r2=1.6, center=true,$fn=24);
    translate([-17,22.3,31])rotate([0,90,0])   cylinder(h=17.5, r1=1.6, r2=1.6, center=true,$fn=24);
    translate([-17,-35.7,8])rotate([0,90,0])   cylinder(h=17.5, r1=1.6, r2=1.6, center=true,$fn=24);
    translate([-17,22.3,8])rotate([0,90,0])   cylinder(h=17.5, r1=1.6, r2=1.6, center=true,$fn=24);
    
    
    //Pi 4 cutout 85.6mm × 56.5mm
    //translate([52,0.8,25])cube([58,87,30], center=true);
    //Pi Zero cut out 65mm x 30mm
    //translate([6,-9,22])cube([42,120,33], center=true);
    
    //Pi PCB cutout
    translate([16,-6.5,20])cube([70,70.5,36], center=true);
    translate([7,-6.5,35])cube([57,52,15], center=true);

    //Ventilation
    
    //#translate([-44,0,20])rotate([90,0,0])   cylinder(h=60, r1=2, r2=2, center=true,$fn=24);
    //translate([-30,0,20])rotate([90,0,0])   cylinder(h=88, r1=2, r2=2, center=true,$fn=24);    
    //translate([-44,-6.5,10])rotate([90,0,0])   cylinder(h=88, r1=2, r2=2, center=true,$fn=24);
    //translate([-30,0,10])rotate([90,0,0])   cylinder(h=88, r1=2, r2=2, center=true,$fn=24);    
    //#translate([-44,0,30])rotate([90,0,0])   cylinder(h=60, r1=2, r2=2, center=true,$fn=24);
    //translate([-30,0,30])rotate([90,0,0])   cylinder(h=88, r1=2, r2=2, center=true,$fn=24);    

}
//Camera cable routing
translate([-33,37,14])  rotate([0,0,0])   cylinder(30, r1=2.3, r2=2.3, center=true,$fn=128);
        }

