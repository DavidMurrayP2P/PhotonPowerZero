# WIRELESS INTERFACE OPTIONS

### This page is incomplete and is a work in progress

The purpose of this page is to document the different Wireless interface options that are avaliable on the raspberry pi, past the inbuilt WiFi and Bluetooth. 

As you know the goal of this project is to make it as easy as possible to deply outdoor computing. We want to be able to easily deploy outdoor single board computers and have sensors or cameras report information back. A large comonent of this is networking and having wireless interfaces that ensure that we can collect the data over a wireless interface. 

This page reviews the options and provides the code to make them work. The goal of this project is to make it as easy as possible. We want the network interface to be low power, with a goal of the network interface is to use less than 5V x 0.1 Amps 0.5W on standby and 5V x 0.15 Amps 0.75W while transmitting. With the Raspberry Pi Zero, this means that we are aming fro less than 5v 0.25 Amps total which is 1.25 Watts in total. Going beyond this we will have implications for batteries and solar pannels.

We also want this to be easy. So Ideally, this should be easy to connect to an IP or IPv6 network. I think that the ideal technology in this space, will likely be 6LowPAN. While this has historically been used for 802.15.4 networks it can be used with sme of the Sub-GHz ISM band radios.

Finally, the solution should cost under 40USD. This is not a hard requirement, initially higher costs are tolerable if there is the opportunity for reduced costs in the future with volume.

Speeds should be in the 50-200Kb/s range. The goal is not to stream live video, but we should be at least able to move a 350KB image within 60 seconds. So 350KB is 2800 bytes. If the link supports 50Kb/s then 2800/50 = 56 seconds.

The following is an attempt to evaluate what is currently out there on the market.

## Design Criteria

The goal of this is to provide you with the information you might need if you are deploying a low power solar powered Rasberry Pi Zero. As you can see below, the Raspberry Pi Zero runs at 5V and 0.1 amps which is 0.5W when idle. The design criteria is to stay under 0.2 Amps when Idle and under 0.25 amps when transmitting data. These are my goals for heat and battery life reasons. Be aware that in the [Reducing Energy Consumption](REDUCING_ENERGY_CONSUMPTION.md) document, the power consumption of the Pi Zero 2W was about 25% higher at idle speeds. These are very much ballpark numbers however.

# Options

 - [Cellular Options](#Cellular-Options)
	- [The SIM7600X 4G HAT](#the-sim7600x-4g-hat)
    - [SIMCOM-7020E](#SIMCOM-7020E) NB-IoT
    - [SIMCOM-A7670SA](#SIMCOM-A7670SA) LTE Cat1 Module

 - [LoRaWAN options](#LoRaWAN-Options)
   - [RAK2245](#RAK2245) - Pi HAT 8 Channel LoRaWAN module SX1301
   - [RAK811](#RAK811) LoRaWan End Device

 - [Other Options](#Other-Options)
    - [NRF24](#NRF24)
    - [RFM69HCW](#RFM69HCW)
  

## Cellular Options

### The SIM7600X 4G HAT

The SIM7600X 4G HAT is a great fit for the Pi. The form factor is great. It appears to work over USB, using spring pins to hit VCC, GND, D+ and D-. You can see the idle power consumption as well as the power consumption under load below. This is a very good module however the price as well as the power consumption are both highert than I would like to see.

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


![Alt text](img/Wireless_Interfaces/Pi_Control.png?raw=true "Title") <p style="text-align:center; font-style:italic;">Raspberry Pi Zero Rough Idle power conspmption </p>

### SIMCOM-7020E

This looked exceptionally convenient as the form factor was already Raspberry Pi Zero sided and the headers matched up, eliminating any wiring. I had hoped that this might just work with regular sim card but unfortuately this needs an NB-IoT specialised sim card.

![Alt text](img/Wireless_Interfaces/SIM7020XNB-IoT.png?raw=true "Title") <p style="text-align:center; font-style:italic;">The power consumption of the SIMCOM-7020E</p>

### SIMCOM-A7670SA 
##### LTE Cat1 Module

I was excited to try this device because it was sold as supporting LTE Cat 1, but this did not recognise a regular sim. I will keep investigating this module but an initial look did not seem promising. This also only supported serial communications.

This did not work with my regular cheap phone sim.

Setup is pretty simple

```sudo raspi-config```

Navigate to Interfacing Options -> Serial. When prompted, select No to disable the serial console, then select Yes to enable the serial port hardware.

```sudo apt install minicom```

On the serial, try a:

```AT```

Then test if a SIM card has been inserted and detected:

```AT+CPIN?```

This will confirm that the modem is responding. Then: 

```AT+CGDCONT=1,"IP","telstra.m2m"```

Enable the network connection:

```AT+CIICR```

Get the IP address assigned to the module:

```AT+CIFSR```

![Alt text](img/Wireless_Interfaces/SIMA7670SA.png?raw=true "Title") <p style="text-align:center; font-style:italic;">The power consumption of the SIMCOM-A7670SA </p>

## LoRaWAN Options

### RAK2245
##### Pi HAT 8 Channel LoRaWAN module SX1301

I ran a Chiprstack Gatway in hot conditions for many years. I powered this device you can see below with a cheap Ali Express style PoE to usb power plug. 

This is the power consumption after booting:

![Alt text](img/Wireless_Interfaces/RAK2245.png?raw=true "Title") <p style="text-align:center; font-style:italic;">The Raspberry Pi Zero is underneath this RAK2224 concentrator.

This RAK2245 worked very well for long periods of time using the Chirpstack Gateway software. You can check out the latest versions here: https://www.chirpstack.io/docs/chirpstack-gateway-bridge/install/raspberry-pi.html This is a concentrator and will act as a LoRaWAN gateway for your deployment of LoRa devices. 

I genuinely had success with this device but when using this device I wal powering it through A PoE to USB plug similar to this: https://www.aliexpress.com/item/33035428356.html

This is a reasonable option for those wanting a Pi and a LoRaWAN gateway but the power draw is too high for solar and battery with the Photon Power Zero.



### RAK811

These LoRa end device modules work very well. I have had over 4km of reliable  transmit range using these. They do not consume excessive power and they were relatively cheap to buy. These seemed to be well designed and I could move binary data over these modules. The issue is that they are limited in speed by bothe technology, the LoRa standard operates down to vely impressive sensitiviy limits. Furthermore, they are also limited by regulation and in many parts of the world, these devices suffer from duty cycle limits. 

While adhereing to Australian limits, we have slowly moved heavily compressed images over these devices, it's not possible in most parts of the world and these will not be faste enough for a real network inteface in Linux, one of the original goals.

![Alt text](img/Wireless_Interfaces/RAK811_pHAT.png?raw=true "Title") <p style="text-align:center; font-style:italic;">Raspberry Pi Zero Rough Idle power conspmption </p>

## Other Options

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

## RFM69HCW

This module is currently being tested. 

You need to ensure thta you have enabled SPI in the raspberry pi

```sudo raspi-config```

Got to intereface options -> Enable SPI

Here is some sample code to test the RFM69HCW after it has been wired:

```
import spidev
import RPi.GPIO as GPIO
import time

# GPIO pin for RFM69's DIO0 (Interrupt)
RFM69_DIO0 = 17

# SPI setup
spi = spidev.SpiDev()
spi.open(0, 0)  # SPI bus 0, chip select 0
spi.max_speed_hz = 5000000

# GPIO setup
GPIO.setmode(GPIO.BCM)
GPIO.setup(RFM69_DIO0, GPIO.IN)

def reset_gpio_pins():
    # Reset any GPIO pins used in the program to a known state
    GPIO.setup(RFM69_DIO0, GPIO.OUT, initial=GPIO.LOW)
    time.sleep(0.1)
    GPIO.setup(RFM69_DIO0, GPIO.IN)

def read_register(register):
    response = spi.xfer2([register & 0x7F, 0])
    return response[1]

def write_register(register, value):
    spi.xfer2([register | 0x80, value])

def initialize_rfm69():
    # Example initialization sequence
    write_register(0x01, 0x04)  # OpMode: Standby
    write_register(0x02, 0x00)  # DataModul: Packet mode, FSK
    write_register(0x03, 0x02)  # Bitrate: 4.8 kbps
    write_register(0x04, 0x8A)
    write_register(0x05, 0x01)  # Fdev: 5 kHz
    write_register(0x06, 0xC3)
    write_register(0x19, 0x42)  # RxBw: 10 kHz
    write_register(0x29, 0xA0)  # RssiThresh: -80 dB
    write_register(0x2E, 0x90)  # SyncConfig: Sync on, sync size = 3
    write_register(0x2F, 0x2D)  # SyncValue1: 0x2D (Sync Word)
    write_register(0x37, 0x90)  # PacketConfig1: Variable length, Manchester encoding
    write_register(0x38, 0x40)  # PayloadLength: 64 bytes
    write_register(0x3C, 0x8F)  # FifoTresh: TxStart on FifoNotEmpty, FifoLevel = 15
    write_register(0x3D, 0x12)  # PacketConfig2: InterPacketRxDelay = 1 bit, RestartRx off
    write_register(0x6F, 0x30)  # TestDagc: Improved margin, use if AfcLowBetaOn=0

def send_packet(data):
    write_register(0x01, 0x0C)  # OpMode: Transmit
    write_register(0x00, 0x80 | len(data))  # Fifo and length
    for byte in data:
        write_register(0x00, byte)
    while not GPIO.input(RFM69_DIO0):  # Wait for DIO0 to go high
        time.sleep(0.01)
    write_register(0x01, 0x04)  # OpMode: Standby

def check_rfm69():
    try:
        # Print the content of some key registers
        print("Register 0x01 (OpMode):", hex(read_register(0x01)))
        print("Register 0x02 (DataModul):", hex(read_register(0x02)))
        print("Register 0x03 (BitrateMsb):", hex(read_register(0x03)))
        print("Register 0x04 (BitrateLsb):", hex(read_register(0x04)))
        print("Register 0x05 (FdevMsb):", hex(read_register(0x05)))
        print("Register 0x06 (FdevLsb):", hex(read_register(0x06)))
        print("Register 0x19 (RxBw):", hex(read_register(0x19)))
        print("Register 0x29 (RssiThresh):", hex(read_register(0x29)))
        print("Register 0x2E (SyncConfig):", hex(read_register(0x2E)))
        print("Register 0x2F (SyncValue1):", hex(read_register(0x2F)))
        print("Register 0x37 (PacketConfig1):", hex(read_register(0x37)))
        print("Register 0x38 (PayloadLength):", hex(read_register(0x38)))
        print("Register 0x3C (FifoTresh):", hex(read_register(0x3C)))
        print("Register 0x3D (PacketConfig2):", hex(read_register(0x3D)))
        print("Register 0x6F (TestDagc):", hex(read_register(0x6F)))
        print("Register 0x10 (Version):", hex(read_register(0x10)))  # Version register to verify communication
    except Exception as e:
        print(f"Error reading registers: {e}")

def main():
    try:
        reset_gpio_pins()
        initialize_rfm69()
        print("RFM69 initialized.")
        
        # Check RFM69 registers
        check_rfm69()

        # Example: Send a packet
        message = "Hello, RFM69"
        send_packet([ord(c) for c in message])
        print("Packet sent.")

    except Exception as e:
        print(f"An error occurred: {e}")

    finally:
        reset_gpio_pins()
        spi.close()
        GPIO.cleanup()

if __name__ == "__main__":
    main()
```


Here is some sample code to recieve the message on another radio

```
import spidev
import RPi.GPIO as GPIO
import time

# GPIO pin for RFM69's DIO0 (Interrupt)
RFM69_DIO0 = 17

# SPI setup
spi = spidev.SpiDev()
spi.open(0, 0)  # SPI bus 0, chip select 0
spi.max_speed_hz = 5000000

# GPIO setup
GPIO.setmode(GPIO.BCM)
GPIO.setup(RFM69_DIO0, GPIO.IN)

def reset_gpio_pins():
    # Reset any GPIO pins used in the program to a known state
    GPIO.setup(RFM69_DIO0, GPIO.OUT, initial=GPIO.LOW)
    time.sleep(0.1)
    GPIO.setup(RFM69_DIO0, GPIO.IN)

def read_register(register):
    response = spi.xfer2([register & 0x7F, 0])
    return response[1]

def write_register(register, value):
    spi.xfer2([register | 0x80, value])

def initialize_rfm69():
    # Example initialization sequence
    write_register(0x01, 0x04)  # OpMode: Standby
    write_register(0x02, 0x00)  # DataModul: Packet mode, FSK
    write_register(0x03, 0x02)  # Bitrate: 4.8 kbps
    write_register(0x04, 0x8A)
    write_register(0x05, 0x01)  # Fdev: 5 kHz
    write_register(0x06, 0xC3)
    write_register(0x19, 0x42)  # RxBw: 10 kHz
    write_register(0x29, 0xA0)  # RssiThresh: -80 dB
    write_register(0x2E, 0x90)  # SyncConfig: Sync on, sync size = 3
    write_register(0x2F, 0x2D)  # SyncValue1: 0x2D (Sync Word)
    write_register(0x37, 0x90)  # PacketConfig1: Variable length, Manchester encoding
    write_register(0x38, 0x40)  # PayloadLength: 64 bytes
    write_register(0x3C, 0x8F)  # FifoTresh: TxStart on FifoNotEmpty, FifoLevel = 15
    write_register(0x3D, 0x12)  # PacketConfig2: InterPacketRxDelay = 1 bit, RestartRx off
    write_register(0x6F, 0x30)  # TestDagc: Improved margin, use if AfcLowBetaOn=0

def receive_packet():
    write_register(0x01, 0x10)  # OpMode: Receive Mode
    print("Waiting for a packet...")

    while not GPIO.input(RFM69_DIO0):  # Wait for DIO0 to go high (PayloadReady)
        time.sleep(0.01)
    
    length = read_register(0x00)  # First byte is the length of the packet
    packet = []
    for i in range(length):
        packet.append(read_register(0x00))
    
    write_register(0x01, 0x04)  # OpMode: Standby
    
    return packet

def check_rfm69():
    try:
        # Print the content of some key registers
        print("Register 0x01 (OpMode):", hex(read_register(0x01)))
        print("Register 0x02 (DataModul):", hex(read_register(0x02)))
        print("Register 0x03 (BitrateMsb):", hex(read_register(0x03)))
        print("Register 0x04 (BitrateLsb):", hex(read_register(0x04)))
        print("Register 0x05 (FdevMsb):", hex(read_register(0x05)))
        print("Register 0x06 (FdevLsb):", hex(read_register(0x06)))
        print("Register 0x19 (RxBw):", hex(read_register(0x19)))
        print("Register 0x29 (RssiThresh):", hex(read_register(0x29)))
        print("Register 0x2E (SyncConfig):", hex(read_register(0x2E)))
        print("Register 0x2F (SyncValue1):", hex(read_register(0x2F)))
        print("Register 0x37 (PacketConfig1):", hex(read_register(0x37)))
        print("Register 0x38 (PayloadLength):", hex(read_register(0x38)))
        print("Register 0x3C (FifoTresh):", hex(read_register(0x3C)))
        print("Register 0x3D (PacketConfig2):", hex(read_register(0x3D)))
        print("Register 0x6F (TestDagc):", hex(read_register(0x6F)))
        print("Register 0x10 (Version):", hex(read_register(0x10)))  # Version register to verify communication
    except Exception as e:
        print(f"Error reading registers: {e}")

def main():
    try:
        reset_gpio_pins()
        initialize_rfm69()
        print("RFM69 initialized.")
        
        # Check RFM69 registers
        check_rfm69()

        # Example: Receive a packet
        packet = receive_packet()
        print("Packet received: ", ''.join(chr(byte) for byte in packet))

    except Exception as e:
        print(f"An error occurred: {e}")

    finally:
        reset_gpio_pins()
        spi.close()
        GPIO.cleanup()

if __name__ == "__main__":
    main()
```