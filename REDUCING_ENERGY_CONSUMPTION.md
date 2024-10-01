# Reducing Energy Consumption on the Pi Zero and Pi Zero 2W

The followingy are my observations from testing the Raspberry Pi Zero's power consumption. Raspberry Pi's docs on this can be found here:  


Summary
Out of the box, the consumption numbers are:

| **Device**                 | **State**         | **Current (A)** | **Voltage (V)** | **Power (W)** |
|----------------------------|-------------------|-----------------|-----------------|---------------|
| Raspberry Pi Zero W        | 0% CPU load       | 0.09            | 5.1             | 0.459         |
| Raspberry Pi Zero W        | 100% CPU load     | 0.16            | 5.1             | 0.816         |
| Raspberry Pi Zero W        | Shutdown          | 0.0378          | 5.1             | 0.192         |
| Raspberry Pi Zero 2 W      | 0% CPU load       | 0.12  | 5.1 | 0.612         |
| Raspberry Pi Zero 2 W      | 100% CPU load     | 0.26            | 5.1             | 1.32          |
| Raspberry Pi Zero 2 W      | Shutdown          | 0.06            | 5.1             | 0.3           |


## Adding things
Adding the following will increase power consumption:

| **Device/Action**                             | **State/Action**                                        | **Current Increase (A)** |
|-----------------------------------------------|---------------------------------------------------------|--------------------------|
| Apple 100 Mbit USB2 adaptor                   | Increase                                                | 0.09 to 0.27             |
| Vantec 1000 Mbit USB3 Gigabit adaptor         | Increase                                                | 0.08 to 0.21             |
| RAK2245 LoRaWAN Concentrator                  | Increase                                                | 0.08 to 0.44             |
| SSH'd in over WiFi on the terminal            | Increase                                                | 0.08 to 0.1              |
| Pi Supply LoRa Hat                                                                      | Idle                                                    | Undetectable increase    |
|   Pi Supply LoRa Hat                                    | Transmitting                     | 0.08 to 0.1              |

## Reducing Power Consumption

| **Action**                                  | **Current Saving (A)**           |
|---------------------------------------------|----------------------------------|
| Disabling HDMI                              | 0.017                            |
| Disabling WiFi                              | 0.006                            |
| Disabling Bluetooth                         | 0.004                            |
| Disabling the On and activity LEDs          | 0.002                            |

### Disable HDMI
If you don't need the screen, you can save 25mA by disabling HDMI. Put the following in /boot/firmwar/config.txt:
```
dtoverlay=vc4-kms-v3d,nohdmi
max_framebuffers=1
disable_fw_kms_setup=1
disable_overscan=1

enable_tvout=0
```
 
 ### Disable WiFi

To do this, add the following to /boot/config.txt:

```
dtoverlay=disable-wifi
```

Then reboot

### Disable Bluetooth 

To do this, add the following to /boot/config.txt:

```
dtoverlay=disable-bt
```

Disable the Bluetooth and WiFi

### Disable Activity LEDs
To disable the activity LEDs permanently, add the following to /boot/config.txt:

```
dtparam=act_led_trigger=none
dtparam=act_led_activelow=off
```

## Pi Zero 2W Disabling cores

Although Jeff shows that you can decrease peak current by disabling cores, the idle power draw is the same for 1 and 4 cores on the Raspberry Pi. Even when under 100% load the total power consumption between 1 and 4 cores will be very similar because although a single core will have a lower power draw but will draw power for a longer period of time. It's an interesting experiment but I would not reccomend: https://www.jeffgeerling.com/blog/2021/disabling-cores-reduce-pi-zero-2-ws-power-consumption-half

## Sources

  Raspberry Pi
  https://github.com/raspberrypi/documentation/blob/develop/documentation/asciidoc/computers/raspberry-pi/power-supplies.adoc
 
https://kittenlabs.de/blog/2024/09/01/extreme-pi-boot-optimization/ 

Jeff Geerling also does a great job at on this page here: https://www.jeffgeerling.com/blogs/jeff-geerling/raspberry-pi-zero-power.
