FROM ubuntu:20.04

ENV TZ=America/New_York
ARG DEBIAN_FRONTEND=noninteractive
ARG username=postgres
ENV TYPE=enhancelog



WORKDIR /install

RUN  apt-get update && \
     apt-get install -y --no-install-recommends apt-utils && \
     apt-get install -y vim git gcc wget make cmake bpfcc-tools sudo zsh && \
     apt-get install -y build-essential binutils mcrypt flex bison && \
     apt-get install -y gawk libssl-dev libexpat-dev  libpcre3 libpcre3-dev lua5.3 liblua5.3-dev  libapr1-dev libaprutil1-dev libxml2-dev libyajl-dev nikto ruby ssl-cert zlibc zlib1g-dev


RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh && \
    sh install.sh && \
    rm install.sh && \
    sudo chsh -s $(which zsh)

RUN  useradd -ms /bin/bash $username && \
     usermod -aG sudo $username &&\
     echo $username 'ALL=(ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo

USER $username

ENV PATH="/opt/PostgreSQL/bin/:${PATH}"

CMD /bin/zsh
