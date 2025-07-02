#!/usr/bin/env python3

import RFM69
from RFM69registers import *
import time
import RPi.GPIO as GPIO
import os

# Constants for configuration
NET = 1
HIGH_POWER = True
POWER_LEVEL = 31

# Frequency settings will be set based on user selection
# These will be determined at runtime

# GPIO Configuration
INT_PIN = 18
RST_PIN = 22
LED_PIN = 5  # Adjust as needed

# Packet settings
PACKET_SIZE = 62
TX_SLEEP_INTERVAL = 0.05
RX_SLEEP_INTERVAL = 0.01
RX_TIMEOUT = 0.5

def initialize_radio(node_id, freq_band, frequency, bitrate, fdev):
    """
    Initializes the RFM69 radio module with the specified configuration.

    Parameters:
    - node_id (int): Unique identifier for the node.
    - freq_band (int): Frequency band constant from RFM69registers (e.g., RF69_433MHZ).
    - frequency (int): Transmit frequency in Hz (e.g., 433000000).
    - bitrate (int): Bitrate in bps.
    - fdev (int): Frequency deviation in Hz.

    Returns:
    - radio (RFM69 object): Configured RFM69 radio object.
    """
    # Setup GPIO for RST_PIN
    GPIO.setmode(GPIO.BOARD)
    GPIO.setup(RST_PIN, GPIO.OUT)

    # Perform hardware reset: set RST low -> high
    GPIO.output(RST_PIN, GPIO.LOW)
    time.sleep(0.1)  # Hold low for 100ms
    GPIO.output(RST_PIN, GPIO.HIGH)
    time.sleep(0.1)  # Wait for radio to stabilize

    # Initialize the radio
    radio = RFM69.RFM69(
        freqBand=freq_band,    # Frequency band
        nodeID=node_id,        # Node ID
        networkID=NET,         # Network ID
        isRFM69HW=True,        # High-power version flag
        intPin=INT_PIN,        # Custom interrupt pin
        rstPin=RST_PIN,        # Custom reset pin
        spiBus=0,              # Custom SPI bus
        spiDevice=1            # Custom SPI device
    )

    print("\nInitializing RFM69 Radio...")
    print("Reading all registers...")
    results = radio.readAllRegs()
    for result in results:
        print(result)

    print("\nPerforming RC Calibration...")
    radio.rcCalibration()

    print("Setting high power and power level...")
    radio.setHighPower(HIGH_POWER)
    radio.setPowerLevel(POWER_LEVEL)

    print("Checking temperature...")
    temperature = radio.readTemperature(0)
    print(f"Temperature: {temperature}°C")

    radio.setFrequency(frequency)

    print(f"Setting Bit Rate to {bitrate} bps and Frequency Deviation to {fdev} Hz...")
    # Setting Bit Rate
    bitrate_msb = (bitrate >> 8) & 0xFF
    bitrate_lsb = bitrate & 0xFF
    radio.writeReg(REG_BITRATEMSB, bitrate_msb)
    radio.writeReg(REG_BITRATELSB, bitrate_lsb)

    # Setting Frequency Deviation
    fdev_msb = (fdev >> 8) & 0xFF
    fdev_lsb = fdev & 0xFF
    radio.writeReg(REG_FDEVMSB, fdev_msb)
    radio.writeReg(REG_FDEVLSB, fdev_lsb)

    return radio

def transmitter(freq_info):
    NODE = 1
    OTHERNODE = 2
    radio = initialize_radio(
        node_id=NODE,
        freq_band=freq_info['freq_band'],
        frequency=freq_info['frequency'],
        bitrate=freq_info['bitrate'],
        fdev=freq_info['fdev']
    )

    def int_to_61_char_string(number):
        number_str = str(number)
        repeat_count = PACKET_SIZE // len(number_str)
        remainder = PACKET_SIZE % len(number_str)
        result = (number_str * repeat_count) + number_str[:remainder]
        result = result[:PACKET_SIZE]
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

    while True:
        print("\n--- Transmitter (TX) Mode ---")
        print("Select an option:")
        print("1. Perform a Site Survey")
        print("2. Transmit a File")
        print("3. Exit TX Mode")

        tx_choice = input("Enter 1, 2, or 3: ")

        if tx_choice == '1':
            print("\nYou chose to perform a Site Survey.")
            print("Starting site survey... Press Ctrl+C to stop.")
            sequence = 0
            try:
                while True:
                    msg = f"{NODE}, {sequence}, {freq_info['band_mhz']}\n"
                    print(f"TX >> {OTHERNODE}: {msg.strip()}")
                    radio.send(OTHERNODE, msg)  # Send without retrying for ACK
                    sequence += 1
                    time.sleep(TX_SLEEP_INTERVAL)
            except KeyboardInterrupt:
                print("\nSite survey interrupted by user.")

        elif tx_choice == '2':
            print("\nYou chose to Transmit a File.")
            file_path = input("Enter the path to the file you want to transmit: ").strip()
            if not os.path.isfile(file_path):
                print("Invalid file path. Please try again.")
                continue
            chunk_size = 60
            chunks = divide_file_into_chunks(file_path, chunk_size)

            print(f"\nTotal number of chunks to send: {len(chunks)}")
            if chunks:
                print(f"First chunk (in bytes): {chunks[0]}")

            sequence = 0
            try:
                for chunk in chunks:
                    msg = int_to_61_char_string(sequence)
                    sequence += 1

                    # Convert bytes to a list of integers
                    data_as_list = list(chunk)

                    # Send the data
                    radio.send(OTHERNODE, data_as_list)
                    print(f"Sent chunk {sequence}/{len(chunks)}")
                    time.sleep(TX_SLEEP_INTERVAL)
                print("\nFile transmission completed.")
            except KeyboardInterrupt:
                print("\nFile transmission interrupted by user.")

        elif tx_choice == '3':
            print("\nExiting Transmitter (TX) Mode.")
            break
        else:
            print("\nInvalid input. Please enter 1, 2, or 3.")

    print("\nShutting down Transmitter...")
    radio.shutdown()
    GPIO.cleanup(RST_PIN)  # Clean up only RST_PIN if transmitter doesn't use LED

def receiver(freq_info):
    NODE = 2
    radio = initialize_radio(
        node_id=NODE,
        freq_band=freq_info['freq_band'],
        frequency=freq_info['frequency'],
        bitrate=freq_info['bitrate'],
        fdev=freq_info['fdev']
    )

    # Initialize GPIO for LED
    GPIO.setup(LED_PIN, GPIO.OUT)
    GPIO.output(LED_PIN, GPIO.LOW)

    def process_packet_loss(received_sequences):
        if not received_sequences:
            print("No packets received. Cannot calculate packet loss.")
            return
        first_seq = received_sequences[0]
        last_seq = received_sequences[-1]
        expected_range = set(range(first_seq, last_seq + 1))
        received_set = set(received_sequences)
        missing_numbers = sorted(expected_range - received_set)
        total_expected = len(expected_range)
        total_received = len(received_set)
        total_missing = len(missing_numbers)
        loss_rate = (total_missing / total_expected) * 100 if total_expected > 0 else 0
        print("\n--- Packet Loss Report ---")
        print(f"Missing packets: {missing_numbers}")
        print(f"Total expected packets: {total_expected}")
        print(f"Total received packets: {total_received}")
        print(f"Total missing packets: {total_missing}")
        print(f"Packet loss rate: {loss_rate:.2f}%")

    while True:
        print("\n--- Receiver (RX) Mode ---")
        print("Select an option:")
        print("1. Receive Site Survey Data")
        print("2. Receive a File")
        print("3. Exit RX Mode")

        rx_choice = input("Enter 1, 2, or 3: ")

        if rx_choice == '1':
            print("\nYou chose to Receive Site Survey Data.")
            print("Starting to receive site survey data... Press Ctrl+C to stop.")
            received_sequences = []
            try:
                while True:
                    GPIO.output(LED_PIN, GPIO.LOW)
                    radio.receiveBegin()
                    timedOut = 0
                    while not radio.receiveDone():
                        time.sleep(RX_SLEEP_INTERVAL)
                        timedOut += RX_SLEEP_INTERVAL
                        if timedOut > RX_TIMEOUT:
                            break
                    if timedOut <= RX_TIMEOUT:
                        GPIO.output(LED_PIN, GPIO.HIGH)
                        sender = radio.SENDERID
                        data = "".join([chr(byte) for byte in radio.DATA])
                        print(f"RX << {sender}: {data.strip()} (RSSI: {radio.RSSI})")
                        try:
                            parts = data.strip().split(',')
                            if len(parts) >= 2:
                                sequence_num = int(parts[1].strip())
                                received_sequences.append(sequence_num)
                        except ValueError:
                            print("Received non-sequence data.")
            except KeyboardInterrupt:
                print("\nReceiving interrupted by user.")
                process_packet_loss(received_sequences)

        elif rx_choice == '2':
            print("\nYou chose to Receive a File.")
            OUTPUT_FILE = input("Enter the path for the output file (e.g., received_file.png): ").strip()
            try:
                # Clear the contents of the output file
                with open(OUTPUT_FILE, 'wb') as f:
                    pass
                print(f"Output file '{OUTPUT_FILE}' initialized.")
            except IOError as e:
                print(f"Failed to initialize output file: {e}")
                continue
            print("Starting to receive file data... Press Ctrl+C to stop.")
            try:
                with open(OUTPUT_FILE, 'ab') as f:
                    while True:
                        GPIO.output(LED_PIN, GPIO.LOW)
                        radio.receiveBegin()
                        timedOut = 0
                        while not radio.receiveDone():
                            time.sleep(RX_SLEEP_INTERVAL)
                            timedOut += RX_SLEEP_INTERVAL
                            if timedOut > RX_TIMEOUT:
                                break
                        if timedOut <= RX_TIMEOUT:
                            GPIO.output(LED_PIN, GPIO.HIGH)
                            sender = radio.SENDERID
                            data = radio.DATA
                            f.write(bytearray(data))
                            f.flush()
                            print(f"Received chunk from {sender} (RSSI: {radio.RSSI})")
            except KeyboardInterrupt:
                print("\nFile reception interrupted by user.")
            except IOError as e:
                print(f"An error occurred while writing to the file: {e}")

        elif rx_choice == '3':
            print("\nExiting Receiver (RX) Mode.")
            break
        else:
            print("\nInvalid input. Please enter 1, 2, or 3.")

    print("\nShutting down Receiver...")
    radio.shutdown()
    GPIO.output(LED_PIN, GPIO.LOW)
    GPIO.cleanup()  # Clean up all GPIO settings

def select_frequency_band():
    """
    Prompts the user to select the frequency band (433 MHz or 916 MHz).

    Returns:
    - freq_info (dict): Dictionary containing frequency configuration.
    """
    while True:
        print("\nSelect Frequency Band:")
        print("1. 433 MHz")
        print("2. 916 MHz")
        freq_choice = input("Enter 1 or 2: ")
        if freq_choice == '1':
            freq_info = {
                'band_mhz': '433',
                'freq_band': RF69_433MHZ,
                'frequency': 433000000,
                'bitrate': 250000,
                'fdev': 50000
            }
            print("Frequency band set to 433 MHz.")
            break
        elif freq_choice == '2':
            freq_info = {
                'band_mhz': '916',
                'freq_band': RF69_915MHZ,
                'frequency': 915000000,
                'bitrate': 250000,
                'fdev': 50000
            }
            print("Frequency band set to 916 MHz.")
            break
        else:
            print("Invalid input. Please enter 1 or 2.")
    return freq_info

def main():
    print("===================================")
    print("       RFM69 Transceiver Tool      ")
    print("===================================")
    while True:
        # Frequency band selection
        freq_info = select_frequency_band()

        print("\nSelect Operation Mode:")
        print("1. Transmitter (TX)")
        print("2. Receiver (RX)")
        print("3. Exit")

        choice = input("Enter 1, 2, or 3: ")

        if choice == '1':
            transmitter(freq_info)
        elif choice == '2':
            receiver(freq_info)
        elif choice == '3':
            print("\nExiting the program.")
            break
        else:
            print("\nInvalid choice. Please enter 1, 2, or 3.")

if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(f"\nAn unexpected error occurred: {e}")
    finally:
        GPIO.cleanup()
