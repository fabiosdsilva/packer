#!/usr/bin/env bash

sleep 30

set -e

sudo apt-get update -y
sudo apt install nginx -y
sudo service nginx start