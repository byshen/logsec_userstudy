#!/bin/bash

sudo pkill vsftpd
sudo cp /install/vsftpd/test0-vsftpd.conf /etc/vsftpd.conf
sudo /usr/local/sbin/vsftpd  /etc/vsftpd.conf &

