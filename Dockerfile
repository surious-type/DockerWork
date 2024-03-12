FROM ubuntu:22.04

# SSH
RUN apt update && apt install  openssh-server sudo -y
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 dev 
RUN echo 'dev:qwerty-123' | chpasswd
RUN service ssh start
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]

# PHP
RUN sudo apt-get install php8.1; sudo update-alternatives --set php /usr/bin/php8.1; sudo apt-get update;
RUN sudo apt -y install php8.1-xml; sudo apt-get -y install php8.1-gd; sudo apt-get -y install php8.1-intl; sudo apt-get -y install php8.1-xsl; sudo apt-get -y install php8.1-ldap; sudo apt-get -y install php8.1-pgsql

# NODEJS
RUN sudo apt install npm; sudo apt install nodejs;

# NETWORK
RUN apt install net-tools
RUN apt install -y iproute2
RUN apt install iputils-ping
