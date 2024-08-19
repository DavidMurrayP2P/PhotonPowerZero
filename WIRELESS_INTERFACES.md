# WIRELESS INTERFACE OPTIONs

The point of this page is to document the different Wireless interface options that are avaliable on the raspberry pi, past the inbuilt WiFi and Bluetooth. 

# Table of Contents

 - [Design Criteria](#design-criteria)
 - [The SIM7600X 4G HAT](#the-sim7600x-4g-hat)

## Design Criteria

The goal of this is to provide you with the information you might need if you are deploying a low power solar powered Rasberry Pi Zero. As you can see below, the Raspberry Pi Zero runs at 5V and 0.1 amps which is 0.5W when idle. The design criteria is to stay under 0.2 Amps when Idle and under 0.3 amps when transmitting data. These are my goals for heat and battery life reasons. Be aware that in the [Reducing Energy Consumption](REDUCING_ENERGY_CONSUMPTION.md) document, the power consumption of the Pi Zero 2W was about 25% higher at idle speeds. These are very much ballpark numbers however.


![Alt text](img/Wireless_Interfaces/Pi_Control.png?raw=true "Title") <p style="text-align:center; font-style:italic;">Raspberry Pi Zero Rough Idle power conspmption </p>


### The SIM7600X 4G HAT

The SIM7600X 4G HAT.

Here is the idle power consumption:

![Alt text](img/Wireless_Interfaces/SIM7600_idle.png?raw=true "Title") <p style="text-align:center; font-style:italic;">Raspberry Pi Zero Rough Idle power conspmption </p

#### Config

Check if the Modem is Detected:

```
sudo mmcli -L
```

Enable and Configure the Modem:

```
sudo mmcli -m 0 --enable
sudo mmcli -m 0 --simple-connect="apn=YOUR_APN"
Replace YOUR_APN with your carrier's APN.
```

You can create a new connection using NetworkManager.

```
sudo nmcli connection add type gsm ifname cdc-wdm0 con-name gsm connection.autoconnect yes apn YOUR_APN
```
Connect to the Network:
```
sudo nmcli connection up gsm
```

Once connected, you should see the wwan0 interface with an IP address like below:


![Alt text](img/Wireless_Interfaces/SIM7600X_wwan0.png?raw=true "Title") <p style="text-align:center; font-style:italic;">Raspberry Pi Zero Rough Idle power conspmption </p

This is the power consumption when lightly loaded.

![Alt text](img/Wireless_Interfaces/SIM7600_load.png?raw=true "Title") <p style="text-align:center; font-style:italic;">Raspberry Pi Zero Rough Idle power conspmption </p

Note that this is just a lot higher than we would ideally like to see. 