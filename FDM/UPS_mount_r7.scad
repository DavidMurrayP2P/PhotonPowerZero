union () {
difference(){
union(){
translate([-36,0,2.4])cube([32,79,7], center=true);    
translate([-13,0,19.5])cube([78,79,31], center=true); 
translate([-23.5,-4.5,19.5])cube([8,69,31], center=true);

}
    //Cube LiPo Battery
    translate([-35,-6.5,20])cube([26,52,37], center=true);

    //Dual cylinder lipo Adafruit style
    translate([-37,0,20])cube([19,69,37], center=true);
    
    //Cavity for camera cable
    translate([-36,0,4.5])cube([26,28,9.4], center=true);
    translate([-35.5,0,0.7])cube([26,16.3,2.4], center=true);
    translate([-12,0,3.05]) rotate([0,-12,0]) cube([25,16.3,2], center=true);

    //Camera cable routing
    #translate([-37.5,38,20])  rotate([0,0,0])   cylinder(27, r1=5, r2=5, center=true,$fn=128);


    //Holes for battery terminals and solar plug
    translate([30,-30,16])cube([100,40.5,40], center=true);
    translate([30,30,16])cube([100,40.5,40], center=true);
    
    //Camera installation
    translate([-39,0,20])cube([20,32,35], center=true);
    
     //battery cable routing
    translate([-37,-37,27])  cube([7,10,20], center=true);
    translate([-52,-35.7,13]) rotate([13,0,0])  cube([7,4.5,19], center=true);
    translate([-36,-32,0])  cube([10,1.8,6], center=true);
    translate([-25.5,-32,0])  cube([10,1.8,6], center=true);
    translate([-46.5,-32,0])  cube([10,1.8,6], center=true);

    //translate([-46.5,-37.5,20.7])rotate([0,90,0])   cylinder(h=12.05, r1=3.75, r2=3.75, center=true,$fn=24);
    translate([-46,-39.5,29])  cube([20,10.5,24], center=true);
   
    translate([-35,-33,2.3])rotate([0,90,0])   cylinder(h=35, r1=2.5, r2=2.5, center=true,$fn=24);
    
    //camera holes
    translate([-51,10.5,30.7])rotate([0,90,0])   cylinder(h=5, r1=1.2, r2=1.2, center=true,$fn=24);
    translate([-51,-10.5,30.7])rotate([0,90,0])   cylinder(h=5, r1=1.2, r2=1.2, center=true,$fn=24);
    translate([-51,10.5,18.2])rotate([0,90,0])   cylinder(h=5, r1=1.2, r2=1.2, center=true,$fn=24);
    translate([-51,-10.5,18.2])rotate([0,90,0])   cylinder(h=5, r1=1.2, r2=1.2, center=true,$fn=24);

    //camera cutout
    translate([-52,0,23])cube([8,13,20], center=true);
    
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

}
//Camera cable routing
translate([-37.5,37,15])  rotate([0,0,0])   cylinder(30, r1=2.3, r2=2.3, center=true,$fn=128);
        }

