#!/usr/bin/env python3

import RFM69
from RFM69registers import *
import time

# Constants for configuration
NODE = 1
OTHERNODE = 2
NET = 1
TIMEOUT = 1
TOSLEEP = 0.01

# Initialize the radio
radio = RFM69.RFM69(RF69_915MHZ, NODE, NET, True)
print("Class initialized")

print("Reading all registers")
results = radio.readAllRegs()
for result in results:
    print(result)

print("Performing rcCalibration")
radio.rcCalibration()

print("Setting high power")
radio.setHighPower(True)
radio.setPowerLevel(31)

print("Checking temperature")
print(radio.readTemperature(0))

radio.setFrequency(915000000)

radio.writeReg(REG_BITRATEMSB, RF_BITRATEMSB_250000)
radio.writeReg(REG_BITRATELSB, RF_BITRATELSB_250000)

radio.writeReg(REG_FDEVMSB, RF_FDEVMSB_50000)
radio.writeReg(REG_FDEVLSB, RF_FDEVLSB_50000)

print("Starting loop...")
sequence = 0
try:
    while True:
        msg = "%d, %d, 915\n" % (NODE, sequence)
        sequence += 1

        print(f"TX >> {OTHERNODE}: {msg}")
        radio.send(OTHERNODE, msg)  # Send without retrying for ACK
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

