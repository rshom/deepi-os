# DEEPi OS #

## Quick Start ##

Flash a new RPi OS microSD card and place the contents of `boot/` into the
the `/boot` directory then boot. Edit `wpa_supplicant.conf` as necessary.

Using `sudo raspi-config` change the following settings.

  * [ ] Set hostname
  * [ ] Enable camera
  * [ ] Expand GPU memory to 256MB
  
Download or clone this repo on the new RPi.

```
sudo apt-get install git
git clone https://github.com/URIL-Group/DEEPi-OS.git
cd DEEPi-OS
sudo sh ./setup.sh
```

>TODO: more testing on that `setup.sh`

Open a browser to http://deepi.local/

## Camera Control ##

The camera is run by the UV4L driver. The driver creates a device at
`/dev/video0` which can be accessed by different software. 

The camera can also be controlled using the python `picamera` library
or using the included `raspistill` and `raspivid` commands. The camera
can only be accessed by one software at a time. 

## Live Feed ##

The live feed is handled the UV4L-WebRTC. It can be viewed and
controlled through a browser on port 8080.

## Camera Commands ##

Camera commands are located in `/usr/local/bin/`.

> TODO: add more commands. They are mostly one liners. 

> TODO: add error checking to commands and responses for if things 
> are not going correctly.

Commands can be scheduled using the crontab interface using the
command `crontab -e` or `sudo crontab -e`.
  
### Snapshot ###

The command `snapshot` gets the latest frame from the camera and saves
it with a timestamp to `/home/pi/pictures/`. Settings are controlled
by `/etc/uv4l/uv4l-raspicam.conf` and match the settings from the live
feed.

## Interfaces ##

For all interfaces requiring authentication the username and password are
left as the default for RPi OS, `pi` and `raspberry` respectively.

### SSH ###

SSH is enabled on the DEEPi by default. SSH gives the user complete
command line control including passwordless sudo privileges.

### FTP ###

The DEEPi runs a [proftpd]() FTP server. This allows quick transfer of
files on and off the device. Files can be accessed using FTP clients
such as Filezilla.

> TODO: Consider swtiching to
> [pureftp](https://www.raspberrypi.org/documentation/remote-access/ftp.md)
> because RPi recommends it.

### HTTP ###

The DEEPi runs a [lighttpd]() HTTP server. This allows users on the same
network to interact with the DEEPi through the browsers. The index page 
contains useful instructions.

Web server files are located at `/var/www/html/`. 

> TODO: make a status display command and page

> TODO: Expand webserver information and manual. A user should be able
> to play around with no knowledge if given a standard DEEPi and the
> web address.

> TODO: make webserver proxy to webrtc for the feed rather than
> hardcoding the link

#### CGI-BIN ####

CGI-BIN commands can be run through the web interface. The binaries are 
located in `/usr/lib/cgi-bin/` and can be run by sending HTTP requests to
`/cgi-bin/`.

> TODO: write more cgi commands

### Time Sync ###

DEEPi uses `timedatectl` to synchronize with ntp servers. The configuration
file is located at `/etc/systemd/timesyncd.conf`.

> TODO: Get time sync working. The university network may be the
> problem, but I cannot tell.
