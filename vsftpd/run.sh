#!/bin/bash


USER="vsftpd"
NEWFTPUSER="newftpuser"

# mount_overlay source overlay target
mount_overlay () {
    sudo mkdir -p $2 && \
    sudo mount -t tmpfs tmpfs $2 && \
    sudo mkdir -p $2/{upper,work} && \
    sudo mount -t overlay overlay -o lowerdir=$1,upperdir=$2/upper,workdir=$2/work $3
}


# compile
cd "/docker_code/app/vsftpd-3.0.3"


make -j4
sudo make install

sudo mkdir /etc/vsftpd/

mount_overlay /tmp/etc /tmp/overlay_etc /etc/vsftpd/

# sudo touch /etc/vsftpd.chroot_list
echo $NEWFTPUSER | sudo tee -a /etc/vsftpd/vsftpd.user_list
sudo mkdir -p /home/$NEWFTPUSER/ftp/upload
sudo chmod 550 /home/$NEWFTPUSER/ftp
sudo chmod 750 /home/$NEWFTPUSER/ftp/upload
sudo chown -R $NEWFTPUSER: /home/$NEWFTPUSER/ftp

echo -e '#!/bin/sh\necho "This account is limited to FTP access only."' | sudo tee -a  /bin/ftponly

echo "/bin/ftponly" | sudo tee -a /etc/shells

sudo usermod $NEWFTPUSER -s /bin/ftponly


echo "config done"

sudo /usr/local/sbin/vsftpd  /etc/vsftpd/vsftpd.conf &




# keep the container running, so we can attach to it
echo "run 'sudo docker exec -it container_name bash' to obtain a shell into the container"
tail -f /dev/null
#/bin/bash
