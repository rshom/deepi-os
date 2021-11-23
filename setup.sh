#!/bin/bash
# Set up script for DEEPi

# TODO: check if running as root
# TODO: enable interfaces
# TODO: set GPU mem to 256MB

# Update raspberry pi
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get autoremove -y
sudo apt-get dist-upgrade -y	# probably unnecessary and may take a while

# Install packages
sudo apt-get install ffmpeg

# Set up NGINX web server
sudo apt-get -y install nginx

# Set up proftpd
apt-get -y install proftpd-basic

# Setup NTP
sudo apt-get -y install ntp

# Set up python
sudo apt-get install python-setuptools python-dev build-essential libpq-dev
# Change default to python3
# NOTE: in some future version this will not be necessary
sudo rm /usr/bin/python
sudo ln -s /usr/bin/python3 /usr/bin/python
sudo mv /usr/bin/pip /usr/bin/pip2
sudo ln -s /usr/bin/pip3 /usr/bin/pip

# Python packages
pip install virtualenv

# Install basic python packages
pip install picamera

# Install pirecorder
pip install pirecorder

# Install pistreamingapp
git clone https://github.com/rshom/pistreamingapp.git ~/pistreamingapp
pip install ws4py
pip install gunicorn
sudo cp pistreamingapp.service /etc/systemd/system/pistreamingapp.service
sudo systemctl start pistreamingapp
sudo systemctl enable pistreamingapp
sudo cp pistreamingapp.nginx /etc/nginx/sites-available/pistreamingapp
sudo ln -s /etc/nginx/sites-available/pistreamingapp /etc/nginx/sites-enabled/pistreamingapp
sudo systemctl restart nginx
