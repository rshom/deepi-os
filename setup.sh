#!/bin/bash
# Set up script for DEEPi

# TODO: enable interfaces
# TODO: set GPU mem to 256MB

# Update raspberry pi
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get autoremove -y
# sudo apt-get dist-upgrade -y	# probably unnecessary and may take a while

# Install packages
sudo apt-get -y install ffmpeg

# Set up NGINX web server
sudo apt-get -y install nginx

# Set up proftpd
sudo apt-get -y install proftpd-basic

# Setup NTP
sudo apt-get -y install ntp

# Set up python
sudo apt-get -y install python3-setuptools python3-dev build-essential libpq-dev
# Change default to python3
# NOTE: in some future version this will not be necessary
sudo rm /usr/bin/python
sudo ln -s /usr/bin/python3 /usr/bin/python

wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
rm get-pip.py

# Python packages
sudo apt-get -y install python3-virtualenv
sudo apt-get -y install python3-picamera
python -m pip install picamerax

# Install pirecorder
# python -m pip install pirecorder
# NOTE: pirecorder relies on numpy. The RPiZ does not handle that well

# Install pistreamingapp
# git clone https://github.com/rshom/pistreamingapp.git ~/pistreamingapp
# python -m virtualenv ~/pistreamingapp/venv
# source ~/pistreamingapp/venv/bin/activate
# pip install --ignore-installed ws4py flask picamera gunicorn
# deactivate
# sudo cp pistreamingapp.service /etc/systemd/system/pistreamingapp.service
# sudo systemctl start pistreamingapp
# sudo systemctl enable pistreamingapp
# sudo cp pistreamingapp.nginx /etc/nginx/sites-available/pistreamingapp
# sudo ln -s /etc/nginx/sites-available/pistreamingapp /etc/nginx/sites-enabled/pistreamingapp
# sudo systemctl restart nginx

# sudo cp pistreamingapp.nginx /etc/nginx/sites-available/pistreamingapp
# sudo ln -s /etc/nginx/sites-available/pistreamingapp /etc/nginx/sites-enabled/pistreamingapp
# sudo systemctl daemon-reload
