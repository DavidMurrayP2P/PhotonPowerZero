//Mount to the solar pannel

//Notes: This is the total object but is printed in multiple parts.

difference(){
union(){
    translate([0,0,2])cube([274.5,225,3.5],center=true,$fn=24);
    translate([-10,0,3.8])cube([102,128,6],center=true,$fn=24);
    
    translate([36.5, -59.5, 26])cube([9,9,48], center=true,$fn=24);
    translate([-56.5, -59.5, 26])cube([9,9,48], center=true,$fn=24);
    translate([36.5, 59.5, 26])cube([9,9,49], center=true,$fn=24);
    translate([-56.5, 59.5, 26])cube([9,9,48], center=true,$fn=24);
    translate([-10,59.5, 26])cube([9,9,48], center=true,$fn=24);
    translate([-10, -59.5, 26])cube([9,9,48], center=true,$fn=24);
    
    //You can comment the 4 lines below if you print in one piece
    translate([-2,75.5, 10])cube([25,41,15], center=true,$fn=128);
    translate([-2, -75.5, 10])cube([25,41,15], center=true,$fn=128);
   
}
    //Uncomment these to half the plate
    //translate([100,0,0])cube([200,250,110],center=true,$fn=24);
    //translate([-100,0,0])cube([200,250,110],center=true,$fn=24);

    //Screws for the two parts to put together
    translate([0, -70, 10])rotate([0,90,0])cylinder(h=40, r=1.8, center=true,$fn=24);
    translate([11, -70, 10])rotate([0,90,0])cylinder(h=10, r=3.5, center=true,$fn=24);
    translate([-15, -70, 10])rotate([0,90,0])cylinder(h=6, r=2.25, center=true,$fn=24);

    translate([0, -90, 10])rotate([0,90,0])cylinder(h=40, r=1.8, center=true,$fn=24);
    translate([11, -90, 10])rotate([0,90,0])cylinder(h=10, r=3.5, center=true,$fn=24);
    translate([-15, -90, 10])rotate([0,90,0])cylinder(h=6, r=2.25, center=true,$fn=24);

    translate([0, 70, 10])rotate([0,90,0])cylinder(h=40, r=1.8, center=true,$fn=24);
    translate([11, 70, 10])rotate([0,90,0])cylinder(h=10, r=3.5, center=true,$fn=24);
    translate([-15, 70, 10])rotate([0,90,0])cylinder(h=6, r=2.25, center=true,$fn=24);

    translate([0, 90, 10])rotate([0,90,0])cylinder(h=40, r=1.8, center=true,$fn=24);
    translate([11, 90, 10])rotate([0,90,0])cylinder(h=10, r=3.5, center=true,$fn=24);
    translate([-15, 90, 10])rotate([0,90,0])cylinder(h=6, r=2.25, center=true,$fn=24);
    

    //subtracting from the bottom plate    
    #translate([-10,0,27.3])cube([104,110,45],center=true,$fn=24);

    translate([-35,0,2])cube([30,105,100],center=true,$fn=24);
    translate([15,0,2])cube([30,105,100],center=true,$fn=24);

    translate([-92,80,2])cube([62,30,100],center=true,$fn=24);
    translate([-92,-80,2])cube([62,30,100],center=true,$fn=24);
    translate([82,0,2])cube([82,110,100],center=true,$fn=24);

    translate([82,80,2])cube([82,30,100],center=true,$fn=24);
    translate([82,-80,2])cube([82,30,100],center=true,$fn=24);
    translate([-92,0,2])cube([62,110,100],center=true,$fn=24);

    translate([21,80,2])cube([21,32,200],center=true,$fn=24);
    translate([-33,-80,2])cube([37,32,100],center=true,$fn=24);
    translate([-33,80,2])cube([37,32,100],center=true,$fn=24);
    translate([21,-80,2])cube([21,32,200],center=true,$fn=24);
    
    //Cutouts for pannel screws
    translate([-130.4,-105.5, 1])cylinder(h=5, r=3.8, center=true,$fn=24);
    translate([-130.4, 105.5 , 1])cylinder(h=5, r=3.8, center=true,$fn=24);
    translate([-130.4,-105.5, 4])cylinder(h=4, r=5.7, center=true,$fn=24);
    translate([-130.4,105.5, 4])cylinder(h=4, r=5., center=true,$fn=24);

    translate([0,-105.5, 1])cylinder(h=5, r=3.8, center=true,$fn=24);
    translate([0, 105.5 , 1])cylinder(h=5, r=3.8, center=true,$fn=24);
    translate([0,-105.5, 4])cylinder(h=4, r=5.7, center=true,$fn=24);
    translate([0,105.5, 4])cylinder(h=4, r=5.7, center=true,$fn=24);
    
    translate([130.4,0, 1])cylinder(h=5, r=3.8, center=true,$fn=24);
    translate([-130.4, 0 , 1])cylinder(h=5, r=3.8, center=true,$fn=24);
    translate([130.4,0, 4])cylinder(h=4, r=5.7, center=true,$fn=24);
    translate([-130.4,0, 4])cylinder(h=4, r=5.7, center=true,$fn=24);
    
    translate([130.4,-105.5, 1])cylinder(h=5, r=3.8, center=true,$fn=24);
    translate([130.4,105.5, 1])cylinder(h=5, r=3.8, center=true,$fn=24);
    translate([130.4,-105.5, 4])cylinder(h=4, r=5.7, center=true,$fn=24);
    translate([130.4,105.5, 4])cylinder(h=4, r=5.7, center=true,$fn=24);
    
    //Heat set inserts
    translate([36.5, 59.5, 0])cylinder(h=8, r=2.3, center=true,$fn=24);
    translate([-56.5, -59.5, 0])cylinder(h=8, r=2.3, center=true,$fn=24);
    translate([-56.5, 59.5,0])cylinder(h=8, r=2.3, center=true,$fn=24);
    translate([36.5, -59.5, 0])cylinder(h=8, r=2.3, center=true,$fn=24);
    translate([-10, 59.5,0])cylinder(h=8, r=2.3, center=true,$fn=24);
    translate([-10, -59.5, 0])cylinder(h=8, r=2.3, center=true,$fn=24);

    translate([36.5, 59.5, 15])cylinder(h=100, r=1.85, center=true,$fn=24);
    translate([-56.5, 59.5, 15])cylinder(h=100, r=1.85, center=true,$fn=24);
    translate([36.5, -59.5, 15])cylinder(h=100, r=1.85, center=true,$fn=24);
    translate([-56.5, -59.5, 15])cylinder(h=100, r=1.85, center=true,$fn=24);
    translate([-10, -59.5, 15])cylinder(h=100, r=1.85, center=true,$fn=24);
    translate([-10, 59.5, 15])cylinder(h=100, r=1.85, center=true,$fn=24);
    
    //Air flow
    translate([-43,0,9])  rotate([90,0,0])   cylinder(h=100, r=7, center=true,$fn=128);
    translate([23,0,9])  rotate([90,0,0])   cylinder(h=100, r=7, center=true,$fn=128);
    
    translate([-23,0,9])  rotate([90,0,0])   cylinder(h=100, r=7, center=true,$fn=128);
    translate([3,0,9])  rotate([90,0,0])   cylinder(h=100, r=7, center=true,$fn=128);
    
    translate([0,48,9])  rotate([0,90,0])   cylinder(h=140, r=7, center=true,$fn=128);
    translate([0,-48,9])  rotate([0,90,0])   cylinder(h=140, r=7, center=true,$fn=128);
    
    translate([0,12,9])  rotate([0,90,0])   cylinder(h=140, r=7, center=true,$fn=128);
    translate([0,-12,9])  rotate([0,90,0])   cylinder(h=140, r=7, center=true,$fn=128);
    
    translate([0,30,9])  rotate([0,90,0])   cylinder(h=140, r=7, center=true,$fn=128);
    translate([0,-30 ,9])  rotate([0,90,0])   cylinder(h=140, r=7, center=true,$fn=128);
}

//Pole mount
translate([-10,0,52])difference(){ 


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

