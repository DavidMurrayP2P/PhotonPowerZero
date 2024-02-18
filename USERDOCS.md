# User Docs of the PhotonPowerZero

This is the user foc of the Photon Power Zero.

Lets start by writing a Raspberry Power light image onto your SD Card. 

[Insert SD card Flashing video here]

After flashing your Rasberry Pi based on the insturctions above plug the power in, without the Photon Power Zero attached. 

![Alt text](img/RPi.jpg?raw=true "Title")

Note that in the image above the Pi is just being powerd via a regular USB cable while we set it up for the Photon Power Zero. You should be able to ssh into it.

Install required packages

sudo apt install python3 tmux neofetch libcamera-apps python3-pip

To implement safe shutdown

Currently, we pull the Shutdown pin high on the raspberry Pi with:

sudo vim /boot/config.txt

Then we insert the following line at the end of the file:

dtoverlay=gpio-shutdown,gpio_pin=21,active_low=1,gpio_pull=up

Download the raspberry pi code onto your raspberry pi. The easiest way to do this is from the command line of your raspberry pi you can:

wget https://raw.githubusercontent.com/DavidMurrayP2P/PhotonPowerZero/main/Code/PPZ_RPi_code.py

You can then provide the file with execute permissions with

chmod 777 PPZ_RPi_code.py

You can then move the file to /usr/bin

sudo mv PPZ_RPi_code.py /usr/bin/PPZ_RPi_code.py

Now you can edit:

nano /etc/rc.local 

Add the following before exit 0

sleep 10
su -l pi -c "tmux new -s monitor -d"
su -l pi -c "tmux send-keys -t monitor '/usr/bin/PPZ_RPi_code.py' C-m"

Change the username pi to whatever your userlevel user is, save and exit.

Now test by running:

sudo /etc/rc.local

Wait 15 seconds then run:

tmux attach

You should have a message saying:

Internet connection working

Turn off you Pi.

Now you can plug in your battery first then your cable that will charge the battery over USB. If your battery is well charged your pi should start booting.

ssh in and then as a user run

tmux attach


Troubleshooting

If for some reason you cannot set up the Wifi and enable ssh from teh image creatino stage you can choose to plug in a HDMI connector  and connect to yoru wifi nad install the open ssh sever via the commad line with:

sudo apt update 
sudo apt install openssh-server.


