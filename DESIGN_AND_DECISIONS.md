# Design and Decisions

This document describes the fundamental design decisions of the Photon Power Zero. This project started in late 2022 because I wanted to solar power a Raspberry Pi. The Raspberry Pi is not class-leading in terms of efficiency or power management, but it is still the best supported Single Board Computer (SBC) with the widest availability of compatible sensors. The Photon Power Zero is a Raspberry Pi Zero HAT that slides over the top of the Raspberry Pi, manages power, and makes solar charging possible, and  addresses, in my opinion, one of the Raspberry Pi's biggest deficiencies; power management.

## Design

You can review the schematic and the board layout, but this section will provide a mile-high overview of this project. The Photon Power Zero is designed around the [BQ2407](https://www.ti.com/lit/ds/symlink/bq24074.pdf) chip and handles the 5-9v input from a USB or a solar panel. It will prioritise powering the ATtiny84 microcontroller, which is the brains of the board. The ATtiny84 is clocked down to 1MHz and consumes little power. This ATtiny84 monitors the LiPo battery voltage through a voltage divider on an ADC pin. When the power level of the battery is high enough, it will pull the enable pin on the AP2161-WG, a high side switch, low. When this switch is pulled low, it will power a 5V DC Boost circuit TPS613222A to power the Raspberry Pi at 5V.

The ATtiny84 is connected to pins on the Raspberry Pi Zero that are rarely used on other Pi HATs. One pin is used to flag that the Raspberry Pi should gracefully shut down. Other pins are used to bit-bang a battery voltage number to the Raspberry Pi. You can read the C code used on the ATtiny to get a better understanding of when the Raspberry Pi will switch on and off.

## Does it work for the Raspberry Pi 3/4/5 or Jetson

These platforms use a lot more power and would require a bigger battery, solar panel and likely a board redesign. Even good quality 2-pin LiPo Batteries often come with wires that only support 1 Amp. This will be a limiting factor on both the charge rate and the current draw when being used. A completely different design would be required to support the 2-5 Amps needed for these more powerful boards.

There is also the problem of heat. Both electronics and batteries perform much better when cool. Subjecting them to outdoor temperatures is challenging. If your panels are going to work, they need to be in the sun. The approach I have taken is to use the solar panel as the shade and to try to maintain an air gap between the panels and the enclosure for the weatherproof container; the solar panel will be very, very hot on a 40-degree Celsius day. Adding a Raspberry Pi 3/4/5 or Jetson Nano project and keeping them in a sealed container with a LiPo battery is likely to see dramatic thermal throttling and a heavily reduced lifespan. This board doesn't support this, and I wouldn't recommend this approach.

## Does this measure LiPo Battery temperature

Yes and no. So, an NTC thermistor can be added. There is a recommendation in the [BQ2407](https://www.ti.com/lit/ds/symlink/bq24074.pdf) documentation. To use this, you must purchase a thermistor that fits into the JST connector. You would also need to desolder the nearby 10k resistor.

By intentional design, the charge current for the battery is always limited to under 1 amp. Given the limited 1 amp charging speed over a 4400mAh battery, we have not found the use of a thermistor necessary, and we have months of testing over at 44C ambient temperature days. Any additional heat generated through charging is negligible compared to the ambient temperature.

## Pins in use

The diagrab below shows which of the Raspberry Pi Pins are used by the Photon Power zero.

![Alt text](img/Pins_in_use_by_PPZ.png?raw=true "Title")<p style="text-align:center; font-style:italic;">These are the pins in use by the Photon Power Zero
