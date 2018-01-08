#!/bin/bash
# VARS
VER='2.1.17'
# PREREQS
sudo apt-get install build-essential "g++" libwxgtk3.0-dev "libcrypto++-dev" libz-dev -y
wget https://hndl.urbackup.org/Client/$VER/urbackup-client-$VER.tar.gz
tar xzf urbackup-client-$VER.tar.gz
# build
cd urbackup-client-$VER
./configure --enable-headless
make -j4
sudo make install
# test and run
sudo urbackupclientbackend -i -v debug
exit 0
