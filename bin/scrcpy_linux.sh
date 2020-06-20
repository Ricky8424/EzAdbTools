#!/bin/bash

# remove old scrcpy
sudo snap remove scrcpy

# install new scrcpy
sudo snap install scrcpy

# making sure adb is installed
sudo apt install adb

# start scrcpy
scrcpy
