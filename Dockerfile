FROM php:latest

RUN apt update && apt install  openssh-server sudo -y

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 dev 

RUN  echo 'dev:qwerty-123' | chpasswd

RUN service ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN apt install net-tools
RUN apt install -y iproute2
RUN apt install iputils-ping

# RUN install-php-extensions xml gd intl xsl ldap pgsql
