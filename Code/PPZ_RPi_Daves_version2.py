#!/usr/bin/python3

import RPi.GPIO as GPIO
import os
import datetime
import sys
import time
import subprocess

# Configure the GPIO pins for data transfer
ALIVE_PIN1 = 16
ALIVE_PIN2 = 20

START_PIN = 13
CLOCK_PIN = 19
DATA_PIN = 26

shutdown_start_hour = 18
shutdown_end_hour = 6

GPIO.setwarnings(False)

def get_unix_time_as_string():
    unix_time = int(time.time())
    return str(unix_time)

def current_system_time():
    now = datetime.datetime.now()
    return now

def get_uptime():
    with open('/proc/uptime', 'r') as f:
        uptime_seconds = float(f.readline().split()[0])
        uptime_hours = (uptime_seconds/3600)
    uptime_hours = str(round(uptime_hours, 2))
    return uptime_hours

def get_temp():
    temp = os.popen('vcgencmd measure_temp').readline()
    temp= temp.replace("temp=","").replace("'C\n","")
    print("The Pi Temp: " + str(temp) + " C")
    return temp

def send_data(event):
    home_directory = os.path.expanduser("~")                                  
    print(home_directory)
    
    img_location = "/home/ph0tons/img/"
    data_location = "/home/ph0tons/data/data.txt"
    time_now = current_system_time()

    message = (str(dev_id) + " " + str(event) + "\n" + "Uptime: " + str(uptime) + " hours\n" + "Batt: " + str(battery_voltage) + "V \n" + "Temp: " + str(temp) + " degrees" + "\nTime: " + str(time_now))
    print(message)
    with open(data_location, 'w') as file:
        file.write(message)

    print ("Taking photo")
    os.system("rm " + str(img_location) + "*")
    string = ("libcamera-still -o " +str(img_location) + str(unix_time_string) + ".jpg")
    #string = ("raspistill -o " + str(img_location) + str(unix_time_string) + ".jpg")
    os.system(string)
    string = ("scp " + str(img_location) + str(unix_time_string) + ".jpg ph0tons@wiki.packets2photons.com:/var/www/html/imgs/" + str(dev_id) + "/")
    os.system(string)
    string = ("scp " + str(data_location) + " ph0tons@wiki.packets2photons.com:/var/www/html/data/" + str(dev_id) + "/" + str(unix_time_string) + ".txt")
    os.system(string)

def set_pin_state():
    GPIO.setmode(GPIO.BCM)

    GPIO.setup(START_PIN, GPIO.IN)
    GPIO.setup(DATA_PIN, GPIO.IN)
    GPIO.setup(CLOCK_PIN, GPIO.IN)

    GPIO.setup(ALIVE_PIN1, GPIO.OUT)
    GPIO.output(ALIVE_PIN1, 1)
    GPIO.setup(ALIVE_PIN2, GPIO.OUT)
    GPIO.output(ALIVE_PIN2, 0)

def shutdown_pin_state():
    GPIO.output(ALIVE_PIN1, 0)
    GPIO.output(ALIVE_PIN2, 1)

def check_internet_connection(hosts=["8.8.8.8", "1.1.1.1", "192.0.43.10"]):
    for host in hosts:
        try:
            result = subprocess.run(["ping", "-c", "1", "-W", "1", host], stdout=subprocess.DEVNULL,
stderr=subprocess.DEVNULL)
            if result.returncode == 0:
                return True
        except Exception as e:
            print(e)

    return False


def get_battery_voltage():
    # Receive and assemble the 16-bit value (MSB first)
    received_value = 0
    GPIO.wait_for_edge(START_PIN, GPIO.FALLING)
    for i in range(8):
        GPIO.wait_for_edge(CLOCK_PIN, GPIO.RISING)
        # Read the data bit from the DATA_PIN and update the received_value
        bit = GPIO.input(DATA_PIN)
        received_value = (received_value << 1) | bit# Wait for the clock to go low
        #print(bit, end="")
    return received_value

def get_average_battery_voltage():

    battery_voltages = []
    for i in range (5):
        battery_voltage = get_battery_voltage()
        #print(" " + str(battery_voltage))
        battery_voltages.append(battery_voltage)
    sorted_voltages = sorted(battery_voltages)
    #print(sorted_voltages)
    middle_idx = len(sorted_voltages) // 2
    median_value = (sorted_voltages[middle_idx - 1] + sorted_voltages[middle_idx]) / 2
    #print("The median value is:", median_value)
    median_value = round(median_value, 2)
    median_value = (median_value *2)/100
    return(median_value)

def is_battery_voltage_stable(voltage_list):

    print("sum of voltages in list is: " + str(sum(voltage_list)))
    average = sum(voltage_list) / len(voltage_list)
    print("The avg: " + str(average))
    half = len(voltage_list) // 2
    first_half = voltage_list[:half]
    second_half = voltage_list[half:]

    first_half_average = sum(first_half) / len(first_half)
    second_half_average = sum(second_half) / len(second_half)
    print("The average of the first half is: " + str(first_half_average))
    print("The average of the second half is: " + str(second_half_average))

    if (first_half_average <= second_half_average):
        return True
    else:
        return False

set_pin_state()
GPIO.output(ALIVE_PIN1, 1)
GPIO.output(ALIVE_PIN2, 1)
first_boot = True
voltage_list =[]
time.sleep(10)
internet = check_internet_connection()
if (internet is True):
	print("Internet connection working")
else:
	print("Internet connection not working")

while True:

    try:
        now = datetime.datetime.now()
        dev_id = os.uname()[1]
        uptime = get_uptime()
        temp = get_temp()
        unix_time_string = get_unix_time_as_string()
        print(unix_time_string)
        battery_voltage = get_average_battery_voltage()
        voltage_list.append(battery_voltage)
        print(str(battery_voltage) + "V")
        print(voltage_list)
        if ((len(voltage_list)) > 5):
            Vbatt_stability = is_battery_voltage_stable(voltage_list)

        if shutdown_start_hour <= now.hour and now.hour < shutdown_end_hour: #modified to and to never shutdown
            event = " Night time shutdown...  "
            send_data(event)
            print("Shutdown the Raspberry Pi")
            shutdown_pin_state()
            os.system("sudo shutdown now")

        elif (float(temp) > 60):
            event = " Temperature shutdown...  "
            send_data(event)
            # Shutdown the Raspberry Pi
            shutdown_pin_state()
            os.system("sudo shutdown now")

        elif (float(battery_voltage) < 3.5):
            print("Low Battery Voltage Detected, getting results in 5 seconds")
            time.sleep(5)
            battery_voltage = get_average_battery_voltage()
            if (float(battery_voltage) < 3.45):
                event = " Low Battery Voltage Shutdown...  "
                time.sleep(2)
                send_data(event)
                shutdown_pin_state()
                os.system("sudo shutdown now")
            else:
                print("The low battery voltage was temporary")

        elif (now.minute == 27):
            if (float(battery_voltage) > 3.8):
                event = "Normal Vbatt High"
                send_data(event)

            elif ((len(voltage_list)) > 5):
                V_batt_trend = is_battery_voltage_stable(voltage_list)
                if (V_batt_trend == True):
                    event = "Normal VBatt stable"
                    send_data(event)
                else:
                    event = "Normal VBatt falling shutting down"
                    send_data(event)
                    shutdown_pin_state()
                    os.system("sudo shutdown now")

            else:
                event = "Normal, VBatt trend pending"
                send_data(event)
            voltage_list =[]

        elif (first_boot == True):
            event = " Starting up "
            send_data(event)
            print("Bootup data send")
            first_boot = False

        time.sleep(57)

    except:
        print("An error... ")
