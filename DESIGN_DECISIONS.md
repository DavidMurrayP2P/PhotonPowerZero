# Design Decisions

This document describes the fundamental design decisions ofthe Photon Power Zero. This project started in late 2022 because I wanted to solar power a Raspberry Pi. The Raspberry Pi is not class leading in terms of power efficiency or power managment, but it is class leading in terms of software support of the operating system and avaliabilyt of compatible sensors. A HAT that sits on the top of the Raspberry Pi, and manges power, and makes solar charging possible addresses one of the Raspberry Pi's deficiencies.

## Does it work for the Raspberry Pi 3/4/5 or Jetson

These platforms use a lot more power and would require a bigger battery, solar pannel and likely a board redesign. Even good quality 2 pin LiPo Batteries often come with wires that only support 1 Amp. This will be a limiting factor on both the charge rate as well as the current draw when being used. The design required to support the 2-5 Amps required by these more powerful boards.  

There is also the problem of heat. Both electronics and batteries perform much better when cool. Subjecting them to outdoor temperatures is challenging. If your panels are going to work, they need to be in the sun. The approach I have taken is to use the solar pannel as the shade and to try to maintain an air gap between the panels and the enclosure for the weather proof container; the  solar pannel will be very very hot on a 40 Degree Celcius day. Adding a Raspberry Pi 3/4/5 or Jetson nano project and keeping them in a sealed container with a LiPo battery is asking to have a bad time. This board doesn't support this and I wouldn't reccomend this approach.

## Does this measure LiPo Battery temperature

Yes and no. So there is the ability to add a NTC thermistor. There is a recommendatinos in the [BQ2407](https://www.ti.com/lit/ds/symlink/bq24074.pdf) documentation. To make use of this you would need to purchase a thermistor that fits into the JST connector left for use. You would also need to desolder the nearby 10k resistor.

By intentional design, the charge current for the battery is always limited to under 1 amp. Given this charge speed over a 4400mAh battery, we have not found the use of a thermistor to be necessary, and we have months of testing over at on 44C ambient temperature days. Put simply, the heat added through charging in negligible in comparison to the ambient temperature.