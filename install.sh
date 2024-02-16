#!/bin/bash

domain=$(cat /etc/xray/domain)
SYSTEM=systemctl
SYSTEMD=/etc/systemd/system
yogz=domain
bot=/etc/yogz
apt update && apt upgrade -y
apt install python3 python3-pip -y
git clone https://github.com/SARTAMP/${yogz}.git
cd domain
pip3 install -r requirements.txt
python3 domain.py
clear
cat >/etc/systemd/system/domain.service << EOF
[Unit]
Description=domain
After=network.target

[Service]
WorkingDirectory=/root
ExecStart=python3 domain.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart domain
systemctl enable domain
systemctl status domain
echo -e ""
echo " Installations complete, type /menu on your bot "
rm -rf /root/install.sh
