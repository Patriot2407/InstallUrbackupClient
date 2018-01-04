#!/bin/bash
sudo apt-get install build-essential "g++" libwxgtk3.0-dev "libcrypto++-dev" libz-dev -y
wget https://hndl.urbackup.org/Client/2.1.17/urbackup-client-2.1.17.tar.gz
tar xzf urbackup-client-2.1.17.tar.gz
cd urbackup-client-2.1.17
./configure
make -j4
sudo make install
sudo urbackupclientbackend -v info
sudo echo "[Unit]
Description=URBackup client
[Service]
Type=simple
Restart=on-failure
RestartSec=5
ExecStart=/usr/local/sbin/urbackupclientbackend -d
ExecStop=killall -TERM srcds_linux
[Install]
WantedBy=multi-user.target" >> /etc/systemd/system/urbackupclient.service
sudo systemctl start urbackupclient
sudo systemctl status urbackupclient
exit 0
