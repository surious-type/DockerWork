FROM ubuntu:22.04

# SSH
RUN apt update && apt install  openssh-server sudo -y
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 dev 
RUN echo 'dev:qwerty-123' | chpasswd
RUN service ssh start
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]

# # PHP
# RUN sudo apt install -y software-properties-common;
# RUN sudo add-apt-repository ppa:ondrej/php;
# RUN DEBIAN_FRONTEND=noninteractive TZ=Europe/Moscow apt-get -y install tzdata
# RUN sudo apt-get -y install php8.1;
# RUN sudo update-alternatives --set php /usr/bin/php8.1; sudo apt-get update;
# RUN sudo apt-get -y install php8.1-xml;
# RUN sudo apt-get -y install php8.1-gd;
# RUN sudo apt-get -y install php8.1-intl;
# RUN sudo apt-get -y install php8.1-xsl;
# RUN sudo apt-get -y install php8.1-ldap;
# RUN sudo apt-get -y install php8.1-pgsql;
# RUN php -v;
# RUN php -m;

# # NODEJS
# RUN sudo apt install -y curl;
# RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - &&\
#     sudo apt-get install -y nodejs
# RUN npm -v;
# RUN node -v;

# # NETWORK
# RUN apt install -y net-tools
# RUN apt install -y iproute2
# RUN apt install -y iputils-ping

RUN sudo apt -y install postgresql postgresql-contrib
RUN sudo systemctl start postgresql.service
RUN sudo -i -u postgres
RUN psql -c "alter user postgres with password 'qwerty-123'"
