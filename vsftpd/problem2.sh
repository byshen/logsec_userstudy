#!/bin/bash

sudo pkill vsftpd
sudo chown ftpuser1:ftpuser1 /etc/vsftpd_user_conf/ftpuser1
sudo cp /install/vsftpd/test2-vsftpd.conf /etc/vsftpd.conf
sudo /usr/local/sbin/vsftpd  /etc/vsftpd.conf &

