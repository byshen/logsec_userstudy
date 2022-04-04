#!/bin/bash

sudo pkill vsftpd
sudo cp /install/vsftpd/test5-vsftpd.conf /etc/vsftpd.conf
sudo /usr/local/sbin/vsftpd  /etc/vsftpd.conf &

nc -l -p 40000