#!/usr/bin/env python3

import RFM69
from RFM69registers import *
import time
import RPi.GPIO as GPIO

# Constants for configuration
NODE = 1 
OTHERNODE = 2
DATA_PLANE = 0
CONTROL_PLANE = 0
TOSLEEP = 0.01
TIMEOUT = 1

OUTPUT_FILE = 'received_file.png'  # File to write received data
file_path = 'logo.png'
chunk_size = 60

# Setup GPIO
GPIO.setmode(GPIO.BOARD)
led = 5
GPIO.setup(led, GPIO.OUT)
GPIO.output(led, GPIO.LOW)

# Initialize the 915MHz radio
radio1 = RFM69.RFM69(
    freqBand=RF69_915MHZ,  # Frequency band
    nodeID=NODE,           # Node ID
    networkID=DATA_PLANE,         # Network ID
    isRFM69HW=True,        # High-power version flag
    intPin=18,             # Custom interrupt pin
    rstPin=22,             # Custom reset pin
    spiBus=0,              # Custom SPI bus
    spiDevice=1            # Custom SPI device
)

print("Class initialized")

print("Reading all registers")
results = radio1.readAllRegs()
for result in results:
    print(result)

print("Performing rcCalibration")
radio1.rcCalibration()

print("Setting high power")
radio1.setHighPower(True)
radio1.setPowerLevel(31)

print("Checking temperature")
print(radio1.readTemperature(0))

radio1.setFrequency(915000000)

radio1.writeReg(REG_BITRATEMSB, RF_BITRATEMSB_250000)
radio1.writeReg(REG_BITRATELSB, RF_BITRATELSB_250000)

radio1.writeReg(REG_FDEVMSB, RF_FDEVMSB_50000)
radio1.writeReg(REG_FDEVLSB, RF_FDEVLSB_50000)

# Initialize the 433MHz radio
radio0 = RFM69.RFM69(
    freqBand=RF69_433MHZ,  # Frequency band
    nodeID=NODE,           # Node ID
    networkID=CONTROL_PLANE,   # Network ID
    isRFM69HW=True,        # High-power version flag
    intPin=16,             # Custom interrupt pin
    rstPin=15,             # Custom reset pin
    spiBus=0,              # Custom SPI bus
    spiDevice=0            # Custom SPI device
)

print("Class initialized")

print("Reading all registers")
results = radio0.readAllRegs()
for result in results:
    print(result)

print("Performing rcCalibration")
radio0.rcCalibration()

print("Setting high power")
radio0.setHighPower(True)
radio0.setPowerLevel(31)

print("Checking temperature")
print(radio0.readTemperature(0))

radio0.setFrequency(433000000)

radio0.writeReg(REG_BITRATEMSB, RF_BITRATEMSB_250000)
radio0.writeReg(REG_BITRATELSB, RF_BITRATELSB_250000)

radio0.writeReg(REG_FDEVMSB, RF_FDEVMSB_50000)
radio0.writeReg(REG_FDEVLSB, RF_FDEVLSB_50000)

packet_size = 62

def int_to_61_char_string(number):
    number_str = str(number)
    repeat_count = packet_size // len(number_str)
    remainder = packet_size % len(number_str)
    result = (number_str * repeat_count) + number_str[:remainder]
    result = result[:packet_size]
    return result

def divide_file_into_chunks(file_path, chunk_size):
    chunks = []
    try:
        with open(file_path, 'rb') as file:
            while True:
                chunk = file.read(chunk_size)
                if not chunk:
                    break
                chunks.append(chunk)
    except FileNotFoundError:
        print(f"The file {file_path} was not found.")
    except IOError as e:
        print(f"An error occurred: {e}")
    
    print(f"Total number of chunks: {len(chunks)}")
    return chunks


# Display the menu options to the user
print("Please choose an option:")
print("1. Send")
print("2. Receive")

# Read the user's response from the keyboard
response = input("Enter 1 or 2: ")

# Check the user's response and perform the corresponding action
if response == '1':
    
    chunks = divide_file_into_chunks(file_path, chunk_size)
    sequence = 0
    chunky = 1337

    try:
        for chunk in chunks:
            #msg = int_to_61_char_string(sequence)
            #msg = "%d, %d, %d\n" % (NODE, sequence, chunk)
            sequence += 1

            # Convert bytes to a list of integers
            data_as_list = list(chunk)
            msg = "%d, %d, %d\n" % (NODE, sequence, chunky)

            if sequence % 2 == 1:
                radio0.send(OTHERNODE, msg)  # Send without retrying for ACK
                print("TX >> {OTHERNODE}: 433 {msg}")
            else: 
                radio1.send(OTHERNODE, msg)  # Send without retrying for ACK
                print("TX >> {OTHERNODE}: 915 {msg}")
            time.sleep(0.16)

            #if (sequence == 100):
            #    sequence = 0
            #    msg = "%d, %d, 915\n" % (NODE, sequence)


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
        print("Finished Transmitting Message")
        # Add code here to perform a site survey
    
    except KeyboardInterrupt:
        # Clean up properly to not leave GPIO/SPI in an unusable state
        pass

elif response == '2':

    # Clear the contents of the output file
    open(OUTPUT_FILE, 'w').close()

    print("Starting loop...")
    try:
        # Open the output file in binary append mode
        with open(OUTPUT_FILE, 'wb') as f:
            while True:
                GPIO.output(led, GPIO.LOW)

                radio1.receiveBegin()
                radio0.receiveBegin()
                timedOut = 0
                while not ((radio1.receiveDone()) or (radio0.receiveDone())):
                    time.sleep(TOSLEEP)
                
                #while not radio0.receiveDone():
                #    time.sleep(TOSLEEP)

                if timedOut <= TIMEOUT:
                    #GPIO.output(led, GPIO.HIGH)
                    #sender = radio1.SENDERID
                    #sender = radio0.SENDERID

                    # Log the received data
                    print(f"RX << {radio0.SENDERID}: (RSSI: {radio0.RSSI} {radio0.DATA}) 433MHz")
                    print(f"RX << {radio1.SENDERID}: (RSSI: {radio1.RSSI} {radio1.DATA}) 915MHz")

                    # Write the received data to the file
                    f.write(bytearray(radio1.DATA))
                    f.write(bytearray(radio0.DATA))
                    f.flush()  # Ensure the data is written to disk immediately

                    # Process ACK if needed
                    #ackReq = radio1.ACKRequested()
                    #ackReq = radio0.ACKRequested()
                    
                    #time.sleep(TIMEOUT / 2)

    except KeyboardInterrupt:
        # Handle program termination gracefully
        print("Interrupt received, shutting down...")

    finally:
        # Cleanup GPIO and shutdown radio properly
        GPIO.output(led, GPIO.LOW)
        radio1.shutdown()
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


else:
    print("Invalid input. Please enter 1 or 2.")

print("Shutting down")
radio1.shutdown()
radio0.shutdown()

