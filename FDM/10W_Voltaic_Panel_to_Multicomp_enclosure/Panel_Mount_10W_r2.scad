//Mount to the solar pannel

//Notes: This is the total object but can be printed in multiple parts.

difference(){
union(){
    translate([15,0,2])cube([274.5,225,2.8],center=true,$fn=24);
    translate([-25,0,3.8])cube([102,128,6],center=true,$fn=24);
    
    translate([21.5, -59.5, 26])cube([9,9,50], center=true,$fn=24);
    translate([-71.5, -59.5, 26])cube([9,9,50], center=true,$fn=24);
    translate([21.5, 59.5, 26])cube([9,9,50], center=true,$fn=24);
    translate([-71.5, 59.5, 26])cube([9,9,50], center=true,$fn=24);
    translate([-25,59.5, 26])cube([9,9,50], center=true,$fn=24);
    translate([-25, -59.5, 26])cube([9,9,50], center=true,$fn=24);
    
    //You can comment the 4 lines below if you print in one piece
    translate([16,75.5, 7])cube([22,41,12], center=true,$fn=128);
    translate([15, -75.5, 7])cube([22,41,12], center=true,$fn=128);
   
}
    //Uncomment these to half the plate
    //translate([115,0,0])cube([200,250,110],center=true,$fn=24);
    //translate([-85,0,0])cube([200,250,110],center=true,$fn=24);

    //Screws for the two parts to put together
    translate([15, -70, 8])rotate([0,90,0])cylinder(h=40, r=1.8, center=true,$fn=24);
    translate([26, -70, 8])rotate([0,90,0])cylinder(h=10, r=3.5, center=true,$fn=24);
    translate([2, -70, 8])rotate([0,90,0])cylinder(h=6, r=2.25, center=true,$fn=24);

    translate([15, -90, 8])rotate([0,90,0])cylinder(h=40, r=1.8, center=true,$fn=24);
    translate([26, -90, 8])rotate([0,90,0])cylinder(h=10, r=3.5, center=true,$fn=24);
    translate([2, -90, 8])rotate([0,90,0])cylinder(h=6, r=2.25, center=true,$fn=24);

    translate([15, 70, 8])rotate([0,90,0])cylinder(h=40, r=1.8, center=true,$fn=24);
    translate([26, 70, 8])rotate([0,90,0])cylinder(h=10, r=3.5, center=true,$fn=24);
    translate([2, 70, 8])rotate([0,90,0])cylinder(h=6, r=2.25, center=true,$fn=24);

    translate([15, 90, 8])rotate([0,90,0])cylinder(h=40, r=1.8, center=true,$fn=24);
    translate([26, 90, 8])rotate([0,90,0])cylinder(h=10, r=3.5, center=true,$fn=24);
    translate([2, 90, 8])rotate([0,90,0])cylinder(h=6, r=2.25, center=true,$fn=24);
    

    //subtracting from the bottom plate    
    translate([-25,0,28])cube([104,110,45.5],center=true,$fn=24);

    translate([-48,0,2])cube([33,105,100],center=true,$fn=24);
    translate([-1,0,2])cube([34,105,100],center=true,$fn=24);

    translate([-94,80,2])cube([36,30,100],center=true,$fn=24);
    translate([-94,-80,2])cube([36,30,100],center=true,$fn=24);
    translate([80,0,2])cube([108,110,100],center=true,$fn=24);

    translate([80,80,2])cube([108,30,100],center=true,$fn=24);
    translate([80,-80,2])cube([108,30,100],center=true,$fn=24);
    translate([-90,0,2])cube([30,110,100],center=true,$fn=24);

    translate([-48,-80,2])cube([37,32,100],center=true,$fn=24);
    translate([-48,80,2])cube([37,32,100],center=true,$fn=24);
    
    translate([-8.5,-80,2])cube([24,32,100],center=true,$fn=24);
    translate([-8.5,80,2])cube([24,32,100],center=true,$fn=24);
    
    //Cutouts for pannel screws
    translate([-115.4,-105.5, 1])cylinder(h=5, r=3.8, center=true,$fn=24);
    translate([-115.4, 105.5 , 1])cylinder(h=5, r=3.8, center=true,$fn=24);
    translate([-115.4,-105.5, 4])cylinder(h=4, r=5.7, center=true,$fn=24);
    translate([-115.4,105.5, 4])cylinder(h=4, r=5., center=true,$fn=24);

    translate([15,-105.5, 1])cylinder(h=5, r=3.8, center=true,$fn=24);
    translate([15, 105.5 , 1])cylinder(h=5, r=3.8, center=true,$fn=24);
    translate([15,-105.5, 4])cylinder(h=4, r=5.7, center=true,$fn=24);
    translate([15,105.5, 4])cylinder(h=4, r=5.7, center=true,$fn=24);
    
    translate([145.4,0, 1])cylinder(h=5, r=3.8, center=true,$fn=24);
    translate([-115.4, 0 , 1])cylinder(h=5, r=3.8, center=true,$fn=24);
    translate([145.4,0, 4])cylinder(h=4, r=5.7, center=true,$fn=24);
    translate([-115.4,0, 4])cylinder(h=4, r=5.7, center=true,$fn=24);
    
    translate([145.4,-105.5, 1])cylinder(h=5, r=3.8, center=true,$fn=24);
    translate([145.4,105.5, 1])cylinder(h=5, r=3.8, center=true,$fn=24);
    translate([145.4,-105.5, 4])cylinder(h=4, r=5.7, center=true,$fn=24);
    translate([145.4,105.5, 4])cylinder(h=4, r=5.7, center=true,$fn=24);
    
    //Heat set inserts
    translate([21.5, 59.5, 0])cylinder(h=8, r=2.3, center=true,$fn=24);
    translate([-71.5, -59.5, 0])cylinder(h=8, r=2.3, center=true,$fn=24);
    translate([-71.5, 59.5,0])cylinder(h=8, r=2.3, center=true,$fn=24);
    translate([21.5, -59.5, 0])cylinder(h=8, r=2.3, center=true,$fn=24);
    translate([-25, 59.5,0])cylinder(h=8, r=2.3, center=true,$fn=24);
    translate([-25, -59.5, 0])cylinder(h=8, r=2.3, center=true,$fn=24);

    translate([21.5, 59.5, 15])cylinder(h=100, r=1.85, center=true,$fn=24);
    translate([-71.5, 59.5, 15])cylinder(h=100, r=1.85, center=true,$fn=24);
    translate([21.5, -59.5, 15])cylinder(h=100, r=1.85, center=true,$fn=24);
    translate([-71.5, -59.5, 15])cylinder(h=100, r=1.85, center=true,$fn=24);
    translate([-25, -59.5, 15])cylinder(h=100, r=1.85, center=true,$fn=24);
    translate([-25, 59.5, 15])cylinder(h=100, r=1.85, center=true,$fn=24);
    
    //Air flow
        
    translate([-30,48,9])  rotate([0,90,0])   cylinder(h=140, r=7, center=true,$fn=128);
    translate([-30,-48,9])  rotate([0,90,0])   cylinder(h=140, r=7, center=true,$fn=128);
    
    translate([-30,12,9])  rotate([0,90,0])   cylinder(h=140, r=7, center=true,$fn=128);
    translate([-30,-12,9])  rotate([0,90,0])   cylinder(h=140, r=7, center=true,$fn=128);
    
    translate([-30,30,9])  rotate([0,90,0])   cylinder(h=140, r=7, center=true,$fn=128);
    translate([-30,-30 ,9])  rotate([0,90,0])   cylinder(h=140, r=7, center=true,$fn=128);
}

//Pole mount
translate([-25,0,53])difference(){ 


difference(){
union(){
cube([102,128,4],center=true);
translate([0,0,20])cylinder(h=37, r1=45, r2=27, center=true,$fn=128);
}
    translate([46.5, 59.5, -25])cylinder(h=100, r=1.8, center=true,$fn=24);
    translate([-46.5, -59.5, -25])cylinder(h=100, r=1.8, center=true,$fn=24);
    translate([-46.5, 59.5, -25])cylinder(h=100, r=1.8, center=true,$fn=24);
    translate([46.5, -59.5, -25])cylinder(h=100, r=1.8, center=true,$fn=24);
    translate([0, 59.5, -25])cylinder(h=100, r=1.8, center=true,$fn=24);
    translate([0, -59.5, -25])cylinder(h=100, r=1.8, center=true,$fn=24);
   
    translate([46.5, 59.5, 2])cylinder(h=2, r=3.2, center=true,$fn=24);
    translate([-46.5, -59.5, 2])cylinder(h=2, r=3.2, center=true,$fn=24);
    translate([-46.5, 59.5,2])cylinder(h=2, r=3.2, center=true,$fn=24);
    translate([46.5, -59.5, 2])cylinder(h=2, r=3.2, center=true,$fn=24);
    translate([0, 59.5,2])cylinder(h=2, r=3.2, center=true,$fn=24);
    translate([0, -59.5, 2])cylinder(h=2, r=3.2, center=true,$fn=24);

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

