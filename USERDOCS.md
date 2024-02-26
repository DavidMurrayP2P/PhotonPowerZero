# User Documentation of the  Photon Power Zero

## Before Installing the Photon Power Zero on the Pi ###

Start by writing a Raspberry Power light image onto your SD Card. 

[Insert SD card Flashing video here]

After flashing your Rasberry Pi using the insturctions above plug the power in, without the Photon Power Zero attached. 

![Alt text](img/RPi.jpg?raw=true "Title")<p style="text-align:center; font-style:italic;">Start by Powering the Raspberry Pi through USB

In the image above the Pi i being powerd via a regular USB cable while we set it up for the Photon Power Zero. 

SSH into your Rasberry Pi with

`ssh [username]@[IP_address_of_Raspberry_Pi]`

Install required packages

`sudo apt update`
`sudo apt install python3 tmux libcamera-apps python3-pip`

Now we are going to allow a graceful shutdown if GPIO Pin 20 is pulled low, the Raspberry Pi will shutdown. This is how a shutdown in initiated from the Photon Power Zerot to the Raspberry pi. 

`sudo nano /boot/config.txt`

Then we insert the following line at the end of the file:

`dtoverlay=gpio-shutdown,gpio_pin=21,active_low=1,gpio_pull=up`

Download the raspberry pi code onto your raspberry pi. The easiest way to do this is from the command line of your raspberry pi you can:

`wget https://raw.githubusercontent.com/DavidMurrayP2P/PhotonPowerZero/main/Code/PPZ_RPi_code.py`

You can then provide the file with execute permissions with

`chmod 777 PPZ_RPi_code.py` 

You can then move the file to /usr/bin

`sudo mv PPZ_RPi_code.py /usr/bin/PPZ_RPi_code.py`

Now you can edit:

`nano /etc/rc.local` 

Add the following before exit 0

```
sleep 10
su -l pi -c "tmux new -s monitor -d"
su -l pi -c "tmux send-keys -t monitor '/usr/bin/PPZ_RPi_code.py' C-m"
```

Change the username pi to whatever your userlevel user is, save and exit.

Now test by running:

`sudo /etc/rc.local`

The command line will appear to hang for 10 seconds before returning you to the terminal. When it does, run:

`tmux attach`

You should have a message saying:

Internet connection working

Turn off you Pi, by removing the USB Power. Now remove the usb cable from your desk, I want to prevent you ffrom powering your Pi through this again.

## Physically Install the Photon Power Zero on the Rasberry Pi

The image below will take you to a youtube video showing you how to carefully install the Photon Power Zero.  

[![Video Thumbnail](img/Installing_PPZ_thumb.png)]( https://youtu.be/dVccMCOYDCo "Physically Installing the Photon Powre Zero on the Raspberry Pi Zero")

Note: Never power the Raspberry Pi via the LiPo Battery and the USB port on the Raspberry Pi. **You cannot charge the battery from the 5v usb port on the Raspberry Pi.**

Now you can plug in your battery first then your cable that will charge the battery over USB. If your battery is well charged your pi should start booting.

ssh in and then as a user run

`tmux attach`

You should see the output of the python program that you have run. You should be seeing your Photon Power Zero reporting a sensible voltage to your Raspberry Pi.


## Troubleshooting ##

If for some reason you cannot set up the Wifi and enable ssh from teh image creatino stage you can choose to plug in a HDMI connector  and connect to yoru wifi nad install the open ssh sever via the commad line with:

```
sudo apt update
sudo apt install openssh-server
```


