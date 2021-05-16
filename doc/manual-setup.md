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
   always available as a back up.
   
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

1. Plug the SD Card in and power up the RPi. Give it around 90 seconds for
   the first boot as the system needs to set itself up.
   
2. SSH into the RPi using username `pi` and password `raspberry` for
   the hostname `raspberrypi.local`. 
   
   The hostname only works with OSX and linux. For Windows, you will
   need to set up a static IP or have a way of knowing the IP of the
   newly set up RPi. 
   
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

8. SSH into the RPi using username `pi` and password `raspberry` for
   the hostname `deepi.local`, or whatever hostname you chose.

## Setup supporting software ##

### Python setup ###

1. Set Python 3 as default.

```.bash
echo "alias python='python3'" >> .bash_aliases
source .bashrc
```

```.bash
cp /usr/bin/python3 /usr/bin/python
```

2. Install basic modules.

```.bash
sudo apt-get install python3-pip
sudo python -m pip install picamera flask gnuicorn

```

### FTP Interfaces ###

FTP is the simplest way to move files on and off of the RPi. ProFTP is
a simple choice.

```.bash
sudo apt-get install proftpd
sudo /etc/init.d/proftpd restart
```

You can now access files on the RPi using an FTP client such as
[FileZilla](https://filezilla-project.org/).


### HTTP Interface ###

HTTP is an effective means of control and information exchange. 

```.bash
sudo apt-get install lighttpd
sudo service lighttpd force-reload
```

You can now access the webserver at
[http://deepi.local](http://deepi.local) assuming the hostname is
deepi. The placeholder page contains more instructions on making
modifications to the webserver.

Set up user directories. <!-- ???: not sure if this is useful or not -->

```.bash
sudo lighttpd-enable-mod userdir
sudo service lighttpd force-reload
mkdir /home/pi/public_html
```

Files placed in the `public_html/` directory can now be accessed at
[http://deepi.local/~pi/](http://deepi.local/~pi/).

A few important directories for the lighttpd server.

  * `/etc/lighttpd/` config files
  * `/var/www/html` DocumentRoot
  * `/usr/lib/cgi-bin` CGI scripts
  * `var/log/lighttpd` logs
  

Enable CGI scripts.

```.bash
sudo lighttpd-enable-mod cgi
sudo service lighttpd force-reload
```

CGI scripts are located at `/usr/lib/cgi-bin`. Scripts must output a
properly formated html page in order to work. Otherwise a 500 server
error is issued. Scripts also must contain no extension and include a shebang
line such as `#!/usr/bin/env python3` in order to run.

The CGI configuration is located at
`/etc/lighttpd/conf-enabled/10-cgi.conf`. For most purposes, it needs
no changes.

<!-- TODO: deploy a flask app to lighttpd using gunicorn -->

## Setup DEEPi software ##

Depending on what functionality, you want the DEEPi to have, refer to the many
subprojects for the remaining set up.

  * DEEPi Bash
  * DEEPi Python
  * DEEPi BRUV
  * DEEPi Cluster
