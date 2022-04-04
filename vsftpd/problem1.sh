#!/bin/bash

sudo pkill vsftpd
sudo cp /install/vsftpd/test1-vsftpd.conf /etc/vsftpd.conf
sudo /usr/local/sbin/vsftpd  /etc/vsftpd.conf &

