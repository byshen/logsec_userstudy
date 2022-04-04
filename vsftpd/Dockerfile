FROM ubuntu:20.04

ENV TZ=America/New_York
ARG DEBIAN_FRONTEND=noninteractive
ARG username=ftp-admin
ARG testuser=ftpuser1
ARG pass=ftpuser1-pass

WORKDIR /

RUN  apt-get update && \
     apt-get install -y vim git gcc wget make cmake sudo zsh && \
     apt-get install -y build-essential binutils mcrypt && \
     apt-get install -y ftp


RUN  apt-get install -y openssl libssl-dev libwrap0-dev netcat

RUN  useradd -ms /bin/bash $username && \
     usermod -aG sudo $username &&\
     echo $username 'ALL=(ALL) NOPASSWD: ALL' | EDITOR='tee -a' visudo

RUN  useradd -ms /bin/bash byshen && \
     usermod -aG sudo byshen &&\
     echo byshen 'ALL=(ALL) NOPASSWD: ALL' | EDITOR='tee -a' visudo

RUN  useradd -ms /bin/bash $testuser &&\
     echo $testuser:$pass | chpasswd &&\
     mkdir /usr/share/empty

RUN  useradd -ms /bin/bash ftpuser2 &&\
     echo ftpuser2:ftpuser2-pass | chpasswd

RUN  useradd -ms /bin/bash ftpuser3 &&\
     echo ftpuser3:ftpuser3-pass | chpasswd

USER $username

CMD /bin/bash
