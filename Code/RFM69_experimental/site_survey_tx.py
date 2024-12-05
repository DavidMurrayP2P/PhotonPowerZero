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
    return chunks


# Display the menu options to the user
print("Please choose an option:")
print("1. Perform a site survey")
print("2. Transmit a file")

# Read the user's response from the keyboard
response = input("Enter 1 or 2: ")

    # Check the user's response and perform the corresponding action
if response == '1':
    print("You chose to perform a site survey.")
    print("Starting loop...")
    sequence = 0
    try:
        while True:
            msg = "%d, %d, 915\n" % (NODE, sequence)
            sequence += 1

            print(f"TX >> {OTHERNODE}: {msg}")
            radio.send(OTHERNODE, msg)  # Send without retrying for ACK
            time.sleep(0.05)

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
    # Add code here to perform a site survey
    
    except KeyboardInterrupt:
        # Clean up properly to not leave GPIO/SPI in an unusable state
        pass

elif response == '2':
    print("You chose to transmit a file.")
    # Example usage
    file_path = 'logo.png'
    chunk_size = 60
    chunks = divide_file_into_chunks(file_path, chunk_size)

    print(f"Total number of chunks: {len(chunks)}")
    if chunks:
        print(f"First chunk (in bytes): {chunks[0]}")

    sequence=0
    try:
        for chunk in chunks:
            msg = int_to_61_char_string(sequence)
            sequence += 1

            # Convert bytes to a list of integers
            data_as_list = list(chunk)

            # Send the data
            radio.send(OTHERNODE, data_as_list)
            time.sleep(0.05)
            #print(f"TX {OTHERNODE},{sequence},{data_as_list}")
            #print(msg)
    except KeyboardInterrupt:
        # Clean up properly to not leave GPIO/SPI in an unusable state
        pass

else:
    print("Invalid input. Please enter 1 or 2.")

print("Shutting down")
radio.shutdown()

