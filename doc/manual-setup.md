# Manual DEEPi Set Up #
> Instructions for setting up a single DEEPi module 

## Flash SD card ##

1. Download the [Raspberry Pi OS
   Lite](https://www.raspberrypi.org/software/operating-systems/)
   image.

	Using the lite version is optimal since it takes up less space and
	uses less power.

2. Flash the image to the SD card.
   
   [Balena Etcher](https://www.balena.io/etcher/) is a useful tool for
   flashing images.
   
## Set up initial boot ##

> NOTE: The prefered method is to use the pi boot loader rather than
> set up manually.

1. Open the `boot/` directory by mounting the SD Card on your computer.
   
   There are a few important files in the `boot/` directory. 

 * `cmdline.txt` is the initial shell command run on start up. It must
   be a single line. 
 * `config.txt` has some settings.
 
 <!-- TODO: include instructions for ethernet device -->
 
2. Create an empty file called `ssh` in the `boot/` directory. This is
   a marker for the pi operating system.
   
3. Create a file called `wpa_supplicant.conf` in the `boot/`
   directory. Fill it with the following code. I use a hotspot on my
   phone for initial set up which matches the network settings we use
   on the router we use in the field. You can add additional networks
   later. Using a phone hotspot initially, means that network is
   always available.
   
```.bash
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=US

network={
        ssid="DEEPiNet"
        scan_ssid=1
        psk="deepinet"
        key_mgmt=WPA-PSK
}
```

## Initial boot ##

1. Plug the SD Card in and power up the RPiZ. Give it around 90 seconds for
   the first boot as the system needs to set itself up.
   
2. SSH into the RPiZ using username `pi` and password `raspberry` for
   the hostname `raspberrypi.local`. 
   
   The hostname only works with OSX and linux. For Windows, you will
   need to set up a static IP or have a way of knowing the IP of the
   newly set up RPiZ. 
   
   <!-- TODO: explain how to do this with windows... -->

3. Connect to an alternate wifi using `sudo raspi-config`. Wifi settings are 
   under `1. System Options > S1 Wireless LAN`.

4. Upgrade the operating system. 

   > This is optional and takes at least few minutes. It takes less
   > time if you just downloaded the latest version of the OS.

```
sudo apt-get update
sudo apt-get upgrade
```

  You can also update through `sudo raspi-config`. 

5. Enable the camera via `sudo raspi-config` under `3 Interface
   Options > P1 Camera`
   
6. Update the hostname via `1 System Options > S4 Hostname`. Set the 
   hostname to `deepi` in most cases.
   
   > NOTE: You could change the username and password as well, but I
   > do not as I am not worried about security, and the standards are
   > easier to remember and share.
   
7. Reboot either through the config menu or with `sudo reboot now`.

8. SSH into the RPiZ using username `pi` and password `raspberry` for
   the hostname `deepi.local`, or whatever hostname you chose.

## Setup supporting software ##

### Python setup ###

1. Set Python 3 as default.

```.bash
echo "alias python='python3'" >> .bash_aliases
source .bashrc
```

2. Install modules.

```.bash
sudo apt-get install python3-pip
python -m pip install picamera

```

## Setup DEEPi software ##

<!-- TODO: write seperate guides for different DEEPi modes -->





