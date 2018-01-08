#!/bin/bash
# VARS
VER='2.1.17'
# PREREQS
sudo apt-get install build-essential "g++" libwxgtk3.0-dev "libcrypto++-dev" libz-dev -y
wget https://hndl.urbackup.org/Client/$VER/urbackup-client-$VER.tar.gz
tar xzf urbackup-client-$VER.tar.gz
# build
cd urbackup-client*
./configure --enable-headless
make -j4
sudo make install
# test and run
sudo urbackupclientbackend -v debug
sudo echo "
[Unit]
Description=UrBackup Client backend
After=syslog.target network.target

[Service]
ExecStart=/usr/local/sbin/urbackupclientbackend --config /etc/default/urbackupclient --no-consoletime
User=root

[Install]
WantedBy=multi-user.target

" >> /etc/systemd/system/urbackup.service
sudo systemctl daemon-reload
sudo systemctl start urbackup
sudo systemctl status urbackup -l
sudo systemctl enable urbackup
exit 0
