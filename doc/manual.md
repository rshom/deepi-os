# DEEPi OS Manual #
> Basic manual for included features in the base DEEPi OS.

## Overview ##

The DEEPi OS is a [RPi OS]() with some preset software and
settings. RPi OS is a Debian based linux distribution designed to run
on the RPi hardware.

## Connectivity ##

The DEEPi can be connected via WiFi or through the USB cable.

### WiFi ###

The module automatically connects to wireless networks using the
following `SSID = DEEPiNet` and `PSK = deepinet`. The simplest way to
start working with the DEEPi is to create a network hotspot with these
settings. Then SSH into the DEEPi and use the command line tools such
as `raspi-config` to connect to an alternate WiFi network.

### USB ###

The DEEPi can also be connected via Ethernet-over-USB as an OTG gadget.

## Interfaces ##

Each DEEPi has multiple servers set up for connectivity. 

### SSH ###

### FTP ###

### HTTP ###

HTTP requests are handled via a [lighttpd]() web server. Files are located at
`/var/www/html`.

### CGI-BIN ###

The web server can also run CGI-BIN scripts. 

CGI scripts are located at `/usr/lib/cgi-bin`. Scripts must output a
properly formated html page in order to work. Otherwise a 500 server
error is issued. Scripts also must contain no extension and include a shebang
line such as `#!/usr/bin/env python3` in order to run.

CGI scripts must return a line that looks like `Content-type:
text/plain` followed by a blank line before anything else can be
returned. Other options are `text/html` and `application/json`.

### NTP ###

## RPi Camera ##

The DEEPi has multiple ways to interact with the RPi Camera. The 

### RPi Camera Software Module ###

The [RPi camera software
module](https://www.raspberrypi.org/documentation/raspbian/applications/camera.md)
included with the RPi OS. The included commands run as bash commands.

### UV4L ###

The UV4L module sets up a device called `/dev/video0`. 

### Python picamera Module ###

The easiest way to create custom scripts is using the python picamera 
module. 

## Utilities ##

### Cron Jobs ###

### rc.local ###

<!-- TODO: investigate if cron is a better option for this -->
