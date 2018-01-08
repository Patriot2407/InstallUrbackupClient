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
Description=ARK Survival Evolved
[Service]
Type=simple
Restart=on-failure
RestartSec=5
StartLimitInterval=60s
StartLimitBurst=3
ExecStart=/Ark/ShooterGame/Binaries/Linux/ShooterGameServer Ragnarok?listen?SessionName=ArkWorld -nosteamclient -server -log
ExecStop=killall -TERM srcds_linux
[Install]
WantedBy=multi-user.target
" >> /etc/systemd/system/urbackup.service
sudo systemctl daemon-reload
sudo systemctl start urbackup
sudo systemctl status urbackup -l
sudo systemctl enable urbackup
exit 0
