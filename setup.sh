#!/bin/bash
# Set up script for DEEPi

# TODO: check if running as root
# TODO: enable interfaces
# TODO: set GPU mem to 256MB

# Set up UV4L
curl https://www.linux-projects.org/listing/uv4l_repo/lpkey.asc | sudo apt-key add -
sudo echo "deb https://www.linux-projects.org/listing/uv4l_repo/raspbian/stretch stretch main" | sudo tee /etc/apt/sources.list.d/uv4l.list
apt-get -y update
apt-get -y install uv4l uv4l-raspicam uv4l-raspicam-extras uv4l-webrtc
cp etc/uv4l-raspicam.conf /etc/uv4l/uv4l-raspicam.conf
# TODO: use sed??? to just edit the right values instead
service uv4l_raspicam restart


# Set up lighttpd
apt-get -y install lighttpd
lighty-enable-mod cgi
# cp etc/lighttpd.conf /etc/lighttpd/lighttpd.conf
cp -rf html/* /var/www/html/
sudo service lighttpd start
sudo service lighttpd reload

# Set up proftpd
apt-get -y install proftpd-basic

# Setup NTP
sudo apt-get -y install ntp

# Include executables
# Regular executable files
chmod +x bin/*
cp bin/* /usr/local/bin/

# Common Gateway interface Executables
chmod +x cgi-bin/*
cp cgi-bin/* /usr/lib/cgi-bin/
