#!/bin/bash


USER="vsftpd"
NEWFTPUSER="ftpuser1"

# mount_overlay source overlay target
mount_overlay () {
    sudo mkdir -p $2 && \
    sudo mount -t tmpfs tmpfs $2 && \
    sudo mkdir -p $2/{upper,work} && \
    sudo mount -t overlay overlay -o lowerdir=$1,upperdir=$2/upper,workdir=$2/work $3
}


# compile
cd "/install/eval_vsftpd"

git checkout enhancelog
# http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/
make -j4

sudo dpkg -i /install/eval_vsftpd/libssl1.0.0_1.0.2n-1ubuntu5.8_amd64.deb

# enhanced log
# sudo cp vsftpd_bingyu vsftpd

# no enhanced log
sudo cp vsftpd_original vsftpd

sudo make install


# prepare files

# config
sudo cp -r /install/vsftpd/files/* /etc/

# rootdir for each user
sudo mkdir -p /home/$NEWFTPUSER/ftp/files
sudo chmod 550 /home/$NEWFTPUSER/ftp
sudo chmod 750 /home/$NEWFTPUSER/ftp/files
sudo chown -R $NEWFTPUSER: /home/$NEWFTPUSER/ftp

sudo cp -r /install/vsftpd/files/ftpuser1/* /home/ftpuser1/ftp/files/
# dir for anno user
sudo mkdir -p /var/ftp








echo "config done"

sudo /usr/local/sbin/vsftpd  /etc/vsftpd.conf &




# keep the container running, so we can attach to it
echo "run 'sudo docker exec -it container_name bash' to obtain a shell into the container"
tail -f /dev/null
#/bin/bash
