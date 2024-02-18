union () {
difference(){
union(){
translate([-36,0,1.4])cube([34,79,6], center=true);    
translate([-13,0,19.5])cube([80,79,31], center=true); 
translate([-23.5,-4.5,19.5])cube([8,69,31], center=true);
}
    //Cube LiPo Battery
    translate([-33.5,-6.5,20])cube([26,50,35], center=true);

    //Dual cylinder lipo Adafruit style
    translate([-36,0,17.2])cube([19,68,37], center=true);
    translate([-36,0,16])cube([12,68,37], center=true);

    //Cavity for camera cable
    #translate([-32.5,0,0.1])cube([20,16.3,3], center=true);
    translate([-11,0,2.5]) rotate([0,-11.5,0]) cube([25,16.3,2.9], center=true);

    //Camera cable routing
    translate([-37.5,38,20])  rotate([0,0,0])   cylinder(27, r1=5, r2=5, center=true,$fn=128);

    //Holes for battery terminals and solar plug
    translate([30,-30,16])cube([98,40.5,40], center=true);
    translate([30,30,16])cube([98,40.5,40], center=true);
    
    //Camera installation
    translate([-41.5,0,20])cube([20,32,35], center=true);
    
    //battery cable routing
    translate([-34,-37,27])  cube([15,10,20], center=true);
    translate([-51.4,-35,11]) rotate([0,0,0])  cylinder(h=30, r1=2, r2=2, center=true,$fn=24);
    

    translate([-35.5,-35,0])  cube([35,1.2,6], center=true);

    //translate([-46.5,-37.5,20.7])rotate([0,90,0])   cylinder(h=12.05, r1=3.75, r2=3.75, center=true,$fn=24);
    translate([-46,-35,29])  cube([20,11.1,24], center=true);
   
    //translate([-35,-35,0.7])rotate([0,90,0])   cylinder(h=40, r1=2, r2=2, center=true,$fn=24);
        
    
    ///camera holes
    translate([-51,10.5,31.5])rotate([0,90,0])   cylinder(h=5, r1=1.2, r2=1.2, center=true,$fn=24);
    translate([-51,-10.5,31.5])rotate([0,90,0])   cylinder(h=5, r1=1.2, r2=1.2, center=true,$fn=24);
    translate([-51,10.5,19])rotate([0,90,0])   cylinder(h=5, r1=1.2, r2=1.2, center=true,$fn=24);
    translate([-51,-10.5,19])rotate([0,90,0])   cylinder(h=5, r1=1.2, r2=1.2, center=true,$fn=24);

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
    translate([16,-6.5,20])cube([70,70.5,36], center=true);
    translate([7,-6.5,35])cube([60,52,15], center=true);

}
//Camera cable routing
translate([-37.5,37,15])  rotate([0,0,0])   cylinder(30, r1=2.3, r2=2.3, center=true,$fn=128);
        }

