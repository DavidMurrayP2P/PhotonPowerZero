#!/usr/bin/env python3

import RFM69
from RFM69registers import *
import datetime
import time
import RPi.GPIO as GPIO

NODE = 2
OTHERNODE = 1
NET = 1
TIMEOUT = 1
TOSLEEP = 0.01

GPIO.setmode(GPIO.BOARD)
led=5
GPIO.setup(led, GPIO.OUT)
GPIO.output(led, GPIO.LOW)

radio = RFM69.RFM69(RF69_915MHZ, NODE, NET, True)
print("class initialized")

print("reading all registers")
results = radio.readAllRegs()
for result in results:
    print(result)

print("Performing rcCalibration")
radio.rcCalibration()

print("setting high power")
radio.setHighPower(True)
radio.setPowerLevel(31)

print("Checking temperature")
print(radio.readTemperature(0))

radio.setFrequency(915000000)

radio.writeReg(REG_BITRATEMSB, RF_BITRATEMSB_250000)
radio.writeReg(REG_BITRATELSB, RF_BITRATELSB_250000)

#radio.writeReg(REG_FDEVMSB, 0x26) # RF_FDEVMSB_5000)
radio.writeReg(REG_FDEVMSB,  RF_FDEVMSB_50000)
#radio.writeReg(REG_FDEVLSB, 0x6C) #RF_FDEVLSB_5000)
radio.writeReg(REG_FDEVLSB, RF_FDEVLSB_50000)

print("starting loop...")
sequence = 0
try:
    while True:
        radio.receiveBegin()
        GPIO.output(led, GPIO.HIGH)
        ender = radio.SENDERID
        msg = "".join([chr(letter) for letter in radio.DATA])
        print(f"RX << {msg} (RSSI: {radio.RSSI})")
        GPIO.output(led, GPIO.LOW)

except KeyboardInterrupt:
    # Clean up properly to not leave GPIO/SPI in an unusable state
    pass

print("shutting down")
radio.shutdown()

