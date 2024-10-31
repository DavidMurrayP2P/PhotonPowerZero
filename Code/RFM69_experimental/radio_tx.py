#!/usr/bin/env python3

import RFM69
from RFM69registers import *
import datetime
import time

NODE = 1
OTHERNODE = 2
NET = 1
TIMEOUT = 1
TOSLEEP = 0.01

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

print("shutting down")
radio.shutdown()

