FROM ubuntu:20.04

ENV TZ=America/New_York 
ARG DEBIAN_FRONTEND=noninteractive
ARG username=vsftpd
ARG testuser=newftpuser
ARG pass=vsftpd123

WORKDIR /docker_code

RUN  apt-get update && \
     apt-get install -y vim git gcc wget make cmake ftp bpfcc-tools sudo zsh && \
     apt-get install -y build-essential binutils mcrypt && \
     apt-get install -y ftp


RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh && \
    sh install.sh && \
    rm install.sh && \
    sudo chsh -s $(which zsh)


RUN  useradd -ms /bin/bash $username && \
     usermod -aG sudo $username &&\
     echo $username 'ALL=(ALL) NOPASSWD: ALL' | EDITOR='tee -a' visudo

RUN  useradd -ms /bin/bash $testuser &&\
     echo $testuser:$pass | chpasswd &&\
     mkdir /usr/share/empty


USER $username


CMD /bin/zsh
