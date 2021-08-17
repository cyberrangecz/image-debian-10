#!/bin/bash -x

# Install python3.9.1
DEBIAN_FRONTEND=noninteractive sudo apt-get update -y && sudo apt-get install -y git wget build-essential zlib1g-dev libbz2-dev \
    libncurses5-dev libreadline-gplv2-dev libsqlite3-dev libssl-dev liblzma-dev tk8.6-dev libgdbm-compat-dev libffi-dev libgdbm-dev libapt-pkg-dev
wget https://www.python.org/ftp/python/3.9.1/Python-3.9.1.tgz
tar -xf Python-3.9.1.tgz
cd Python-3.9.1
./configure --enable-optimizations
sudo make -j 4 --quiet
sudo make install -j 4 --silent
sudo ln -sf /usr/local/bin/python3.9 /usr/local/bin/python3
cd ..
sudo rm -rf Python-3.9.1*

# Install ansible
sudo pip3 install ansible --no-input

# Install python-apt module
git clone https://salsa.debian.org/apt-team/python-apt.git
cd python-apt/
git checkout 1.8.2  # depends on libapt-pkg-dev version
sudo python3 setup.py build
sudo python3 setup.py install
cd ..
sudo rm -rf python-apt

# Install more modules
sudo pip3 install asn1crypto blinker chardet configobj "idna<3" jsonpatch jsonpointer jsonschema jwt oauthlib python-debian python-debianbts requests six urllib3 --no-input
