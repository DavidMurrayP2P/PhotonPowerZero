#Photon Power Zero Design Decisions

In this doc we will describe some of the fundamental design decisions around the Photon Power Zero. This project started in late 2022 because I wanted to solar power a Raspberry Pi.

Some have asked me why I did not create a solar charger that would work for the Raspberry Pi 3/4/5 and the Jetson Nano. The answer to this is because these platforms use a lot more power and wold requrie a bigger battery, solar pannel and likely a board redesign. Even the good quality 2 pin LiPo Batteries often come with wires that only support 1 Amp. With a Lipo battery often dropping to 3.4 Volts when depleted this is only 3.4 Watts. This will be a limiting factor on both the charge rate as well as the current draw when being used. 

There is also the problem of heat. Both electronics and batteries perform much better when cool. Subjecting them to outdoor temperatures is difficult. If your pannels are going to work, they need to be in the sun. The approach we have taken is to use the solar pannel as the shade and to try to maintain an air gap between the pannels and the enclosure for the weather proof container; the backside of that solar pannel will be very very hot on a 40 Degree Celcius day. Adding a Raspberry Pi 3/4/5 or Jetson nano project and keeping them in a sealed container with a LiPo battery is asking to have a bad time. 
