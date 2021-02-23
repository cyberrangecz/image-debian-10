#!/bin/bash -x

# Remove old python
DEBIAN_FRONTEND=noninteractive sudo apt-get remove -y python3 && sudo apt-get -y autoremove

# Install python3.9.1
DEBIAN_FRONTEND=noninteractive sudo apt-get update -y && sudo apt-get install -y wget build-essential libreadline-gplv2-dev libncursesw5-dev \
     libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev 
#&& sudo apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev
wget https://www.python.org/ftp/python/3.9.1/Python-3.9.1.tgz
tar -xf Python-3.9.1.tgz
cd Python-3.9.1
./configure --enable-optimizations
make -j 4 --quiet
sudo make install -j 4 --quiet
sudo ln -s /usr/local/bin/python3.9 /usr/bin/python3
sudo ln -s /usr/local/bin/pip3.9 /usr/bin/pip3
cd ..
sudo rm -rf Python-3.9.1*

# Install ansible
sudo pip3 install ansible --no-input
