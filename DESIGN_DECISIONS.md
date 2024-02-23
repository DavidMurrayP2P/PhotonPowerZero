# Design Decisions

This document describe the fundamental design decisions around the Photon Power Zero. This project started in late 2022 because I wanted to solar power a Raspberry Pi.

## Does it work for the Raspberry Pi 3/4/5 or Jetson

These platforms use a lot more power and would requrie a bigger battery, solar pannel and likely a board redesign. Even the good quality 2 pin LiPo Batteries often come with wires that only support 1 Amp. This will be a limiting factor on both the charge rate as well as the current draw when being used. The design to support this would be a different board.  

There is also the problem of heat. Both electronics and batteries perform much better when cool. Subjecting them to outdoor temperatures is difficult. If your panels are going to work, they need to be in the sun. The approach I have taken is to use the solar pannel as the shade and to try to maintain an air gap between the pannels and the enclosure for the weather proof container; the backside of that solar pannel will be very very hot on a 40 Degree Celcius day. Adding a Raspberry Pi 3/4/5 or Jetson nano project and keeping them in a sealed container with a LiPo battery is asking to have a bad time. 

## Does this measure LiPo Battery temperature

Yes and no. So there is the ability to add a NTC thermistor. There is a recommendatinos in the [BQ2407](https://www.ti.com/lit/ds/symlink/bq24074.pdf) documentation. To make use of this you would need to purchase a thermistor that fits into the JST connector left for use. You would also need to desolder a resistor. 

By default, the charge current for the battery is always limited to under 1 amp. Given this charge speed over a 4400mAh battery, we have not found the use of a thermistor to be necessary, and we have months of testing over at on 44C ambient temperature days.