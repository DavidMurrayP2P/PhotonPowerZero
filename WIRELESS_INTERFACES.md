# WIRELESS INTERFACE OPTIONs

The purpose of this page is to document the different Wireless interface options that are avaliable on the raspberry pi, past the inbuilt WiFi and Bluetooth. 

As you know the goal of this project is to make it as easy as possible to deply outdoor computing. We want to be able to easily deploy outdoor single board computers and have sensors or cameras report information back. A large comonent of this is networking and having wireless interfaces that ensure that we can collect the data over a wireless interface. 

This page reviews the options and provides the code to make them work. The goal of this project is to make it as easy as possible. We want the network interface to be low power, with a goal of the network interface is to use less than 5V x 0.1 Amps 0.5W on standby and 5V x 0.15 Amps 0.75W while transmitting. With the Raspberry Pi Zero, this means that we are aming fro less than 5v 0.25 Amps total which is 1.25 Watts in total. Going beyond this we will have implications for batteries and solar pannels.

We also want this to be easy. So Ideally, this should be easy to connect to an IP or IPv6 network. I think that the ideal technology in this space, will likely be 6LowPAN. While this has historically been used for 802.15.4 networks it can be used with sme of the Sub-GHz ISM band radios.

Finally, the solution should cost under 40USD. This is not a hard requirement, initially higher costs are tolerable if there is the opportunity for reduced costs in the future with volume.

Speeds should be in the 50-200Kb/s range. The goal is not to stream live video, but we should be at least able to move a 350KB image within 60 seconds. So 350KB is 2800 bytes. If the link supports 50Kb/s then 2800/50 = 56 seconds.

The following is an attempt to evaluate what is currently out there on the market.
 


# Table of Contents

 - [Design Criteria](#design-criteria)
 - [The SIM7600X 4G HAT](#the-sim7600x-4g-hat)
 - RFM69HCW
 - SIM7020E NB-IoT
 - SIMCOM A7670SA LTE Cat1 Module
 - RAK2245 Pi HAT 8 Channel LoRaWAN module SX1301
 - [NRF24](#NRF24)

## Design Criteria

The goal of this is to provide you with the information you might need if you are deploying a low power solar powered Rasberry Pi Zero. As you can see below, the Raspberry Pi Zero runs at 5V and 0.1 amps which is 0.5W when idle. The design criteria is to stay under 0.2 Amps when Idle and under 0.25 amps when transmitting data. These are my goals for heat and battery life reasons. Be aware that in the [Reducing Energy Consumption](REDUCING_ENERGY_CONSUMPTION.md) document, the power consumption of the Pi Zero 2W was about 25% higher at idle speeds. These are very much ballpark numbers however.


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


![Alt text](img/Wireless_Interfaces/SIM7600X_wwan0.png?raw=true "Title") <p style="text-align:center; font-style:italic;">Raspberry Pi Zero Rough Idle power conspmption </p>

This is the power consumption when lightly loaded.


![Alt text](img/Wireless_Interfaces/SIM7600_load.png?raw=true "Title") <p style="text-align:center; font-style:italic;">Raspberry Pi Zero Rough Idle power conspmption </p>

Note that this is just a lot higher than we would ideally like to see. 

### NRF24

The NRF24L01+ is amazingly cheap on places like AliExpress and seems like a great option. 

To get this going you are going to need to wire this up: 

![Alt text](img/Wireless_Interfaces/nrf24.png?raw=true "Title") <p style="text-align:center; font-style:italic;">Raspberry Pi Zero Rough Idle power conspmption </p>

We also want to enable the SPI interface, by running:

```
sudo raspi-config
```

Then enable the SPI interface.

Install the correct libraries

```
sudo apt-get update
sudo apt-get install python3-pip python3-dev libboost-python-dev libboost-thread-dev git
cd RF24
./configure
make
sudo make install
cd pyRF24
sudo python3 setup.py install
```

If you get an error message about not finding lib_boost. Then:  
  
 ```
 sudo find / -name "libboost_python*.so*"
 ```

Find the name and then create a symbolic link. Create a link from your specific lib boost to something more generic:

```
sudo ln -s /usr/lib/arm-linux-gnueabihf/libboost_python311.so /usr/lib/arm-linux-gnueabihf/libboost_python3.so
```
Then try to install again:
```
sudo python3 setup.py install
```

This is the reciever code:
```
from RF24 import *
from time import sleep

# Setup for Raspberry Pi
radio = RF24(25, 0)  # CE is connected to GPIO 25 (Pin 22), CSN to SPI0 CE0 (Pin 24)

def setup():
    if not radio.begin():
        print("Radio hardware not responding")
        return False
    radio.setPALevel(RF24_PA_MIN)
    radio.setDataRate(RF24_1MBPS)
    radio.setCRCLength(RF24_CRC_16)
    radio.openReadingPipe(1, 0xF0F0F0F0E1)
    radio.startListening()
    print("Radio successfully initialized")
    return True

def receive():
    while True:
        if radio.available():
            while radio.available():
                message = radio.read(32)
            print("Received message: {}".format(message.decode('utf-8')))
        else:
            print("No message received")
        sleep(1)

if __name__ == "__main__":
    if setup():
        radio.printDetails()
        receive()
```

This is the trasmitter code:

```
import spidev
from RF24 import *
from time import sleep

# Setup for Raspberry Pi
radio = RF24(25, 0)  # CE is connected to GPIO 25 (Pin 22), CSN to SPI0 CE0 (Pin 24)

def setup():
    # Set SPI speed using spidev
    spi = spidev.SpiDev()
    spi.open(0, 0)  # Open SPI bus 0, device (CS) 0
    spi.max_speed_hz = 500000  # Set SPI speed to 500 kHz
    spi.close()

    print("Initializing the radio...")
    if not radio.begin():
        print("Radio hardware not responding")
        return False
    radio.setPALevel(RF24_PA_MIN)
    radio.setDataRate(RF24_1MBPS)
    radio.setCRCLength(RF24_CRC_16)
    radio.openWritingPipe(0xF0F0F0F0E1)
    radio.stopListening()
    print("Radio successfully initialized")
    return True

def transmit():
    counter = 0
    while True:
        message = f'Hello {counter}'.encode('utf-8')
        print(f"Sending message: {message.decode('utf-8')}")
        result = radio.write(message)
        if result:
            print("Message sent successfully")
        else:
            print("Message sending failed")
        counter += 1
        sleep(1)

if __name__ == "__main__":
    if setup():
        radio.printDetails()
        transmit()
```

![Alt text](img/Wireless_Interfaces/nrf_load.png?raw=true "Title") <p style="text-align:center; font-style:italic;">NRF24 module transmitting</p>

Overall this module is very cheap and low power. There are however, a few issues. Firstly it uses the 2.4GHz band, which is also used by the WiFi Module so there will potentially be some inteference issues using both at the same time in nearby proximiyt.. Secondly, the trasmission difference is not dissimilar from the onboard WiFi. There is no evidence that we it will be possible to reach the a 1km distance. Finally, on the raspberry Pi, it does not enumerate as a network interface. While it might be possible to create a driver that might create a 6LowPAN style interface on the Pi, the  nRF24L01+ only supports payload sizes up to 32 bytes. To make something that can reach a minimum efficiency requirement, the minimum fram size should be 127 octets. This is what 802.15.4 allows.