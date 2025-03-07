#!/usr/bin/env python3

import RFM69
from RFM69registers import *
import time
import RPi.GPIO as GPIO

# Constants for configuration
NODE = 2
NET = 1
TOSLEEP = 0.03
TIMEOUT = 0.5
OUTPUT_FILE = 'received_file.png'  # File to write received data

# Setup GPIO
GPIO.setmode(GPIO.BOARD)
led = 5
GPIO.setup(led, GPIO.OUT)
GPIO.output(led, GPIO.LOW)

# Initialize the radio
#radio = RFM69.RFM69(RF69_915MHZ, NODE, NET, True)
radio915 = RFM69.RFM69(
    freqBand=RF69_915MHZ,  # Frequency band
    nodeID=NODE,           # Node ID
    networkID=NET,         # Network ID
    isRFM69HW=True,        # High-power version flag
    intPin=18,             # Custom interrupt pin
    rstPin=22,             # Custom reset pin
    spiBus=0,              # Custom SPI bus
    spiDevice=1            # Custom SPI device
)

print("Class initialized")

print("Reading all registers...")
results = radio915.readAllRegs()
for result in results:
    print(result)

print("Performing rcCalibration")
radio915.rcCalibration()

print("Setting high power")
radio915.setHighPower(True)
radio915.setPowerLevel(31)

print("Checking temperature")
print(radio915.readTemperature(0))

radio915.setFrequency(915000000)

radio915.writeReg(REG_BITRATEMSB, RF_BITRATEMSB_250000)
radio915.writeReg(REG_BITRATELSB, RF_BITRATELSB_250000)

radio915.writeReg(REG_FDEVMSB, RF_FDEVMSB_50000)
radio915.writeReg(REG_FDEVLSB, RF_FDEVLSB_50000)

# Clear the contents of the output file
open(OUTPUT_FILE, 'w').close()

print("Starting loop...")
try:
    # Open the output file in binary append mode
    with open(OUTPUT_FILE, 'wb') as f:
        while True:
            GPIO.output(led, GPIO.LOW)

            radio915.receiveBegin()
            timedOut = 0
            while not radio915.receiveDone():
                time.sleep(TOSLEEP)

            if timedOut <= TIMEOUT:
                GPIO.output(led, GPIO.HIGH)
                sender = radio.SENDERID

                # Log the received data
                #print(f"RX << {sender}: (RSSI: {radio.RSSI})")

                # Write the received data to the file
                f.write(bytearray(radio915.DATA))
                f.flush()  # Ensure the data is written to disk immediately

                # Process ACK if needed
                ackReq = radio915.ACKRequested()
                
                #time.sleep(TIMEOUT / 2)

except KeyboardInterrupt:
    # Handle program termination gracefully
    print("Interrupt received, shutting down...")

finally:
    # Cleanup GPIO and shutdown radio properly
    GPIO.output(led, GPIO.LOW)
    radio.shutdown()
    print("Shutdown complete")
    
    # Read the file and extract the second column values
    with open(OUTPUT_FILE, 'r') as file:
        received_numbers = [int(line.split(',')[1]) for line in file]

if received_numbers:
    # The first and last sequence numbers
    first_seq = received_numbers[0]
    last_seq = received_numbers[-1]

    # Define the expected range of numbers from first_seq to last_seq
    expected_range = set(range(first_seq, last_seq + 1))
    # Convert received numbers to a set
    received_set = set(received_numbers)

    # Find the missing numbers
    missing_numbers = expected_range - received_set

    # Calculate the loss rate
    total_expected = len(expected_range)
    total_received = len(received_set)
    total_missing = len(missing_numbers)

    loss_rate = (total_missing / total_expected) * 100

    print(f"Missing numbers: {sorted(missing_numbers)}")
    print(f"Total expected packets: {total_expected}")
    print(f"Total received packets: {total_received}")
    print(f"Total missing packets: {total_missing}")
    print(f"Packet loss rate: {loss_rate:.2f}%")

