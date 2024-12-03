#!/usr/bin/env python3

import RFM69
from RFM69registers import *
import time

# Constants for configuration
NODE = 1
NODE1 = 11
OTHERNODE = 2
NET = 1
NET1 = 11
TIMEOUT = 1
TOSLEEP = 0.01

# Initialize the radio
radio433 = RFM69.RFM69(RF69_433MHZ, NODE, NET, True)
radio915 = RFM69.RFM69(RF69_915MHZ, NODE1, NET1, True)
print("Class initialized")

print("Reading all registers")
results = radio915.readAllRegs()
for result in results:
    print(result)

results = radio433.readAllRegs()
for result in results:
    print(result)

print("Performing rcCalibration")
radio915.rcCalibration()
radio433.rcCalibration()

print("Setting high power")
radio915.setHighPower(True)
radio433.setHighPower(True)
radio915.setPowerLevel(31)
radio433.setPowerLevel(31)

print("Checking temperature")
print(radio915.readTemperature(0))
print(radio433.readTemperature(0))

radio915.setFrequency(915000000)
radio433.setFrequency(433000000)

radio915.writeReg(REG_BITRATEMSB, RF_BITRATEMSB_250000)
radio915.writeReg(REG_BITRATELSB, RF_BITRATELSB_250000)

radio433.writeReg(REG_BITRATEMSB, RF_BITRATEMSB_250000)
radio433.writeReg(REG_BITRATELSB, RF_BITRATELSB_250000)

radio915.writeReg(REG_FDEVMSB, RF_FDEVMSB_50000)
radio915.writeReg(REG_FDEVLSB, RF_FDEVLSB_50000)

radio433.writeReg(REG_FDEVMSB, RF_FDEVMSB_50000)
radio433.writeReg(REG_FDEVLSB, RF_FDEVLSB_50000)

print("Starting loop...")
sequence = 0
try:
    while True:
        msg = "%d, %d, 915\n" % (NODE, sequence)
        sequence += 1

        print(f"TX >> {OTHERNODE}: {msg}")
        radio433.send(OTHERNODE, msg)  # Send without retrying for ACK
        time.sleep(0.05)

        #print("Receiving...")
        #radio.receiveBegin()
        #timedOut = 0
        #while not radio.receiveDone():
        #    timedOut += TOSLEEP
        #    time.sleep(TOSLEEP)
        #    if timedOut > TIMEOUT:
        #        print("Nothing received")
        #        break

        #if timedOut <= TIMEOUT:
        #    sender = radio.SENDERID
        #    msg = "".join([chr(letter) for letter in radio.DATA])
        #    print(f"RX << {sender}: {msg} (RSSI: {radio.RSSI})")
        #    # Removed ACK-related processing
        #    time.sleep(TIMEOUT / 2)
except KeyboardInterrupt:
    # Clean up properly to not leave GPIO/SPI in an unusable state
    pass

print("Shutting down")
radio.shutdown()

