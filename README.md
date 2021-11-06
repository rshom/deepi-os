<<<<<<< HEAD
# DEEPi Operating System #
> Boot files for auto setting up a DEEPi and allowing control via the
> other DEEPi projects.

## TODO ##

<!-- TODO: this needs a contents file -->

<!-- TODO: pull some stuff in the payload stuff to seperate projects
and have a script that pulls everything together always downloading
the latest version.-->

<!-- TODO: look into sub repositories with git -->

<!-- TODO: auto-installed
https://github.com/silvanmelchior/RPi_Cam_Web_Interface 
--> 

<!--but change a few settings, like save point, ftp, default
configs. Nice if i could make my changes while still being able to
download the latest version and auto install from the git server-->

<!-- TODO: need a way to search for enabled DEEPis -->

<!-- TOOD include network set up for usb hot plug -->

* [ ] Time sync (NTP)
* [ ] deepi libraries
* [ ] deepi scripts
  * [ ] bash
  * [ ] python
* [ ] Auto behavior ```crontab -e```
  * [ ] services vs crontab
  * [ ] start up behaviour 
  * [ ] timed behaviour (services)
* [ ] HTTP server (lighttpd) 
  * [ ] HTML control page
  * [ ] HTML help page (from this doc)
  * [ ] CGI-BIN
* [ ] cron job set up
* [ ] check out the apps that are 3rd party software
  https://elinux.org/Rpi_Camera_Module#3rd_party_software

## Overview ##

The project provides all of the base software requirements to set up a
DEEPi camera system.[^1] <!-- TOOD: link to the deepi project -->

This project is based on
[pi-boot-script](https://gitlab.com/JimDanner/pi-boot-script/tree/master). Read
the README provided with that project for more information.  Some of
the scripts have been modified, but most of the work is contained in
the payload.

  * **Raspbian**
  * **Install script**
  * **FTP server**
  * **HTTP server**
  * **NTP client**
  * **Crontab services**
  * **Executables**
  * **Libraries**

## Install ##

  1. Flash a raspian lite SD card
  2. Mount the card on a computer (the boot partition should show up
     as boot)
  3. Copy all files from this project into the boot partition, with
     the exception of `cmdline.txt` overwriting as necessary. `cp -rf
     deepi-os/boot/* /Volumes/boot/`

	 > **WARNING**: do not overwrite `cmdline.txt` entirely. The
	 > portions saying `conlole=serial0,??????` and
	 > `root=PARTUUID=????????-??` are unique to the Raspbian build
	 > and the RPi will not complete its boot without correct values.


### Boot files ###

After flashing a raspian image to an SD, it can be mounted on any
computer, but only the `boot/` partition will come up. All of the
files needed for automated install can be dumped into this partition,
replacing previous contents where necessary.

  * **config.txt** is a standard configuration file for raspian. Modified to
    enable ethernet gadget and camera on boot.
  * **cmdline.txt** is a standard boot command for raspian. This is
    the first command run by the system on every boot. **This file is
    very important.**
=======
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
>>>>>>> 3b3b2e233c80190e69477424cd20698cd0a1ff86

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

<<<<<<< HEAD
This project uses the following license: MIT.

[^1]: This is a software based project, and does not require that a
    DEEPi case be used on the camera system being created even though
    it was specifically made with that use case in mind.
=======
> TODO: Get time sync working. The university network may be the
> problem, but I cannot tell.
>>>>>>> 3b3b2e233c80190e69477424cd20698cd0a1ff86
