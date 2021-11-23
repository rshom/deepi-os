# DEEPi OS #
> Set up individual DEEPi

## Setup ##

1. Set up new pi using the latest [Raspberry Pi
   OS](https://www.raspberrypi.com/software/operating-systems/). For
   most applications the files in the `boot/` directory are helpful. The 
   
2. Log on to the pi and run the set up script

```
git clone https://github.com/rshom/deepi-os
cd deepi-os
sh ./setup.sh
```

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

