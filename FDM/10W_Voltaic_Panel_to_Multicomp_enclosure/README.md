# 10W Voltaic Solar Panel to MULTICOMP PRO MC002194 enclosure

This is a panel mount for Voltaic's 10W solar panel. All of these Parts are designed to be printed in ABS or better. You may try printing in PLA if your use case is indoor only or you cliamet is cool. Otherwise, the reccomendation is ABS or better, such as ASA.

The image below shows the entire stet of printed parts but they must be printed in multipl parts

![Alt text](../../img/10W_voltaic_to_Multicomp_MC002194.png?raw=true "Title")<p style="text-align:center; font-style:italic;">Connect the 10W volatic Panel to the Mutlicomp MC002194 Enclosure and 25mm OD PVC Pipe. This is obviously printed in two parts. 

The image above shows what the mount looks like but you can print it in two parts. This should be divided up for you already in the files pole_mount.stl and Panel_Mount_10W.stl

Most people will need to print the Panel_Mount_10W.stl in two parts: Panel_Mount_10W_1st_half.stl and Panel_Mount_10W_2nd_half.stl

When you print these parts, you will need to sink the brass heat set inserts:

![Alt text](../../img/heat_set_inserts.jpg?raw=true "Title")<p style="text-align:center; font-style:italic;">You will need to put 6 heat set inserts in the bottom side of the panel mount

After you do this you will most likely need to clean out the holes. I like to put the m3 screws in on the opposite side to force any plastic out and clear the path.

![Alt text](../../img/clearing_hole_after_heat_set_inserts.jpg?raw=true "Title")<p style="text-align:center; font-style:italic;">Make sure you clear the holes by putting m3 screws in the wrong way around.

You have likely printed the panel mount in two parts. They screw together with M3 heat set inserts and M3 screws.

![Alt text](../../img/heat_set_inserts_two_parts.jpg?raw=true "Title")<p style="text-align:center; font-style:italic;">Heat set inserts for the two parts

You can then srcew the two parts together:

![Alt text](../../img/two_parts_joined_together.jpg?raw=true "Title")<p style="text-align:center; font-style:italic;">Screw the two parts together

Use 50mm M3 screws to put screw pole_mount.stl into the panel mount.

![Alt text](../../img/Put_together_1.jpg?raw=true "Title")<p style="text-align:center; font-style:italic;">Use 50mm M3 screws to put screw pole_mount.stl into the panel mount.


![Alt text](../../img/Put_together_2.jpg?raw=true "Title")<p style="text-align:center; font-style:italic;">Screwed together

![Alt text](../../img/Mount_Pi_PPZ_inside_Multicomp_MC002194.png?raw=true "Title")<p style="text-align:center; font-style:italic;">Mount inside the Multicomp MC002194 Enclosure

![Alt text](../../img/panel_multicomp_mount.jpg?raw=true "Title")<p style="text-align:center; font-style:italic;">Physically Fitting it together, put a 25mm PVC pipe to connect the structure to the soil or a Ubolt clamp
panel_multicomp_mount.jpg

![Alt text](../../img/case_mount_inside_Multicomp_MC002194.jpg?raw=true "Title")<p style="text-align:center; font-style:italic;">The case mount goes inside the multicomp. you need to drill a hole in the aluminium and use a Waterproof cable gland PG-7

## Bill of Materials (BOM)

#### MULTICOMP PRO MC002194 
Metal Enclosure, Small, Extruded Aluminium, 51.6 mm, 119 mm, 115.1 mm Links:
- https://www.jaycar.com.au/aluminium-enclosure-with-clear-ends/p/HB6294
- https://il.farnell.com/multicomp/mc002194/multipurpose-enclosure-alum-silver/dp/2830527
- https://www.newark.com/multicomp-pro/mc002194/enclosure-4-53-x-4-69-x-2-03/dp/57AC8361
- https://www.devicemart.co.kr/goods/view?no=12072777
- https://dk.farnell.com/en-DK/multicomp/mc002194/multipurpose-enclosure-alum-silver/dp/2830527

#### Fixing hardware 

These are for mounting the Raspberry Pi Zero to the case inside the enclosure
 - 4x M2.5 heat set inserts like https://www.aliexpress.com/item/1005004535859664.html
 - M2.5 Mounting hardware https://www.aliexpress.com/item/1005004275784627.html
  - Waterproof Cable Gland https://core-electronics.com.au/cable-gland-pg-9-size-0-158-to-0-252-cable-diameter-pg-9.html OR https://www.adafruit.com/product/761
  
These are for bolting pole_mount.stl and Panel_Mount_10W.stl together. 
  -  6 x M3 heat set inserts OD 5mm Length 10mm https://www.aliexpress.com/item/1005004535859664.html - These go on the underside of the panel fitting
 - 6 x M3 50mm Staintelss steel hex bolt https://www.thefastenerfactory.com.au/stainless-steel-hex-socket-head-cap-screw-m3-x-50mm-100pc

#### 10W Voltaic Panel

 - Solar Panel https://voltaicsystems.com/10-watt-panel-etfe/ OR https://www.adafruit.com/product/5369 OR https://core-electronics.com.au/5v-10w-solar-panel-etfe-voltaic-p110.html
 - Right angled Female 3.5x1.1mm - 5.5x2.1mm: https://voltaicsystems.com/A106 or https://www.adafruit.com/product/4287
 - If you get an EFTE panel you need to get ETFE Panel Screw & Washer Set https://voltaicsystems.com/mount-set-etfe/ these are 4-40 but an M3 should work

## Finished Construction

The 25mm PVC pipe can go in the ground or you could use a UBolt. You can modify the scad to support any size round post that you like.

![Alt text](../../img/Finished_Voltaic_to_Multicomp_MC002194.jpg?raw=true "Title")<p style="text-align:center; font-style:italic;">Finished construction
