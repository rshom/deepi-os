# DEEPi Operating System #

> boot files for auto setting up a DEEPi

## TODO ##

* [x] network connection (eth over usb)
* [x] auto-setup and install
* [ ] Time sync (NTP)
* [x] FTP server (proftpd)
* [ ] deepi libraries
* [ ] deepi scripts
  * [ ] bash
  * [ ] python
* [ ] Auto behavior ```crontab -e```
  * [ ] services vs crontab
  * [ ] start up behaviour 
  * [ ] timed behaviour (services)
* [ ] HTTP server (lighttpd) 
  * [x] install
  * [ ] HTML control page
  * [ ] HTML help page (from this doc)
  * [ ] CGI-BIN
* [ ] cron job set up

## Overview ##

The project provides all of the base software requirements to set up a
DEEPi camera system.

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
  3. Copy all files from this project into the boot partition
     overwriting as necessary. `cp -rf deepi-os/boot/* /Volumes/boot/`
  4. Modify one-time-script.conf as desired
  5. Plug SD into PiZero and allow to run. Pi will reboot a few times
     before finishing. (for this to work an internet connection must
     open either through wifi or through usb over ethernet.)
  6. Check logs

## Boot files ##

After flashing a raspian image to an SD, it can be mounted on any
computer, but only the `boot/` partition will come up. All of the
files needed for automated install can be dumped into this partition,
replacing previous contents where necessary.

  * **config.txt** is a standard configuration file for raspian. Modified to
    enable ethernet gadget and camera on boot.
  * **cmdline.txt** is a standard boot command for raspian. This is the
    first command run by the system on every boot. 
  * **unattended** mounts the files and controls the basic procedure for 
    the install.
  * **one-time-script.conf** contains configuration for the install
    script which controls the actual install.
  * **payload/** contains a partial linux file system. All files will
    be moved to the root file system replacing previous contents.

## One time script ##

The one time script runs on first boot. It is controlled by the
configuration file `boot/one-time-script.conf`. See the comments for
more information. The script itself is at
`boot/payload/usr/local/bin/one-time-script.sh` and
`boot/payload/usr/local/bin/packages-script.sh`. For most purposes, the actual script should not be modified.

<!-- TODO: modify the script to allow the user to set the hostname-->

The config file also includes a list of packages to install, which are
installed by the packages script. An internet connection is needed to
install the scripts. This works either over WiFi, via a hot-spot, or
using ethernet over USB with internet sharing. Some college campuses
do not allow internet sharing and make WiFi connections
difficult. Therefore, using a hotspot is often the best option.

## Payload ##

The payload contains a partial linux file system which gets copied
over to the root file system as part of the install. This can include
configuration files and scripts.

<!-- TODO: update this as necessary -->
  * **`/usr/local/bin/`** holds executable files
  * **`/etc/`** holds configuration files
  * **`/var/www/`** holds webserver files
  * **`/lib/systemd/system/`** holds service files
  * **`/var/spool/cron/crontabs/`** holds the user crontab files for
    scheduling tasks
  * **`/home/pi/bin`** holds user editable executable files

<!-- ???: do I want to have a media folder in the home directory to
hold the data or just make folders in the home directory -->
  
More details are below or contained in the file comments.

More information about the linux Filesystem Hierarchy Standard at
[https://refspecs.linuxfoundation.org/](https://refspecs.linuxfoundation.org/
"https://refspecs.linuxfoundation.org/") and
[https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard
"https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard").

## Ethernet gadget ##

Setting up the pi as an ethernet gadget for ethernet over usb.

<!-- NOTE: a potentially simpler way is to load the modules from
cmdline.txt instead of loading them via the payload. -->

<!-- TODO: adapt [ethernet gadget
tutorial](https://www.isticktoit.net/?p=1383) which is a far more
robust way to get eth or usb support-->

<!-- TODO: make a seperate tutorial explaining how to do this -->


## Package installation ##

<!-- TODO: install packages without internet (can I zip them)-->

I added some auto-install packages to the conf file. However, these files will not install without an internet connection, so they must be installed manually.

  * **ntp** <!-- ???: is this installed now -->
  * **python3**
  * **python3-pip**
  * **proftpd**
  * **screen**
  * **lighttpd**
  

## NTP client ##

NTP is handled by the `/etc/ntp.conf` file which is in the
payload. NTP is installed in the initial 

<!-- TODO: test NTP -->

<!-- TODO: set up ntp in payload -->

<!-- TODO: add server to conf file -->

<!-- TODO: NTP server should be added to the onetime conf file and the
onetime script should insert it into the ntp.conf file -->


## FTP Server ##

Proftpd is installed in the initial package installation. It has a
configuration file located at `/etc/proftpd/proftpd.conf`. The default
configuration is fine, so it is not currently included in the payload.

Ligttpd is autostarted on every bootup. See `/etc/init.d/lighttpd` for
more information.

<!-- TODO: make sure the ftp server restarts if it ever has an issue -->

The FTP server has read access to the entire file sytem, but it only
has write access to the home directory of the user (pi). To modify
other files, the user must SSH into the system and use `sudo`
privileges. Permissions could be changed, but this setup protects low
level functionality from inexperienced users. There is no way to login
to the FTP server as root. 
<!-- TODO: FTP upload to WWW should be made possible -->

## HTTP server ##


Lighttpd (pronounced lighty) is installed in the initial package
installation, and its configuration files are moved over with the
payload.

  * `/etc/lighttpd/lighttpd.conf`
  * `/var/www/html/`
  * `/var/www/cgi-bin/`
  

```sh
# Test server with a conf file
sudo lighttpd -D -f etc/lighttpd/lighttpd.conf
```

Ligttpd is autostarted on every bootup. See `/etc/init.d/lighttpd` for
more information.

<!-- TODO: make sure lighttpd restarts if it ever has an error -->

The HTTP server allows simple requests to be sent to the system which
can trigger complex scripts. The `lighttpd.conf` file controls what
types of executables can be run from the `cgi-bin` directory. Pointing
a web browser (or other HTTP GET request) to one of these scripts
causes the server to execute that script and display the results. See
`test.sh` and `test.py` included in the payload as examples. CGI
scripts must be made executable (`chmod +x myscript`), must specify a
valid interpretor, and must return a valid HTTP response (see examples).

```
Status: 200
Content-Type: text/plain

content
```

<!-- TODO: crossref properly --> The code block above shows a very
simple valid HTTP response. Which can be printed by the CGI
script. **The empty line before the content is important.** The
response can also be much more complex to include entire webpages.

**CGI scripts should be kept as simple as possible.** Complex behavior
should be controlled by libraries and executables.

## DEEPi Software ##

The DEEPi OS payload includes software custom made for the DEEPi. This
software sometimes comes from independent projects and
repositories. Therefore, more up to date versions may be available on
the official repositories for the respective software.

### Executables ###

Custom executables are placed in `/usr/local/bin/` or
`/usr/local/sbin/` (for sudo). The majority of any code should be held
in the libraries. Executables should simply hold main logic for a
given task. 

  * [ ] take still
  * [ ] stream live
  * [ ] record video
  * [ ] time lapse

Executables can also be placed in `/home/pi/bin/` which gives them
fewer permission, but allows them to be uploaded by less experienced
users. User executables can access the local libraries and call local
executables.

### Libraries ###

Custom libraries are placed in `/usr/local/lib`. The majority of the
code should be included in such libraries which can be executed by
binaries.

  * [ ] python library
  * [ ] bash library??
  * [ ] C++ library??

## Task Schedule ##

A crontab file is included in the payload. It is located at
`/var/spool/cron/crontabs/pi` and allows the user to set up scheduled
tasks. Cron job are limited to every minute and cannot be called in
smaller time units. If there is a need for smaller time units, a
script must be used. However, that script can be called by a cron job.

The correct way to edit a crontab is to invoke `crontab -e` and in
most cases the user should do that. However, for mass production, the
crontab included in the payload can be edited before loading the DEEPi.

Crontab files use a limited `PATH` variable, so it is best to just
type out the full executable path for a command.

**Sample crontabs**
<!-- TODO: make some sample crontab lines -->
```
@reboot CMD
@yearly CMD
@monthly CMD
@daily CMD
@hourly
* * * * * CMD
*/10 * * * *
```

<!-- TODO: crontabs can be installed from text file. Therefore, a
better technique would be to drop the crontab into the boot folder and
have the one-time-script install it. -->


## Contributors ##

* [Russell Shomberg](https://rshom.github.io)
* [Brennan Phillips](https://web.uri.edu/uril/)
<!-- TODO: add contributors-->

<!-- If you would like to contribute to this project, let me know. -->

## License ##
<!--- If you're not sure which open license to use see https://choosealicense.com/--->

This project uses the following license: MIT.
