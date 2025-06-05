FROM ubuntu:22.04

# Создание пользователя и SSH
RUN apt update && apt install -y openssh-server sudo
RUN useradd -rm -d /home/dev -s /bin/bash -g root -G sudo -u 1000 dev
RUN echo 'dev:qwerty-123' | chpasswd
RUN mkdir -p /var/run/sshd
RUN mkdir -p /home/dev/projects && chown dev:root /home/dev/projects
RUN echo "Hello"

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

ENV PHP_VERSION="8.2"

# Установка PHP
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php -y
RUN DEBIAN_FRONTEND=noninteractive TZ=Europe/Moscow apt-get -y install tzdata
RUN apt-get update && apt-get install -y \
  php${PHP_VERSION} php${PHP_VERSION}-xml php${PHP_VERSION}-gd php${PHP_VERSION}-intl \
  php${PHP_VERSION}-xsl php${PHP_VERSION}-ldap php${PHP_VERSION}-pgsql \
  php${PHP_VERSION}-zip php${PHP_VERSION}-xdebug php${PHP_VERSION}-mbstring \
  php${PHP_VERSION}-curl

# Настройка Xdebug
RUN echo "[xdebug]" >> /etc/php/${PHP_VERSION}/cli/php.ini && \
    echo "xdebug.mode=debug,coverage" >> /etc/php/${PHP_VERSION}/cli/php.ini && \
    echo "xdebug.start_with_request = yes" >> /etc/php/${PHP_VERSION}/cli/php.ini && \
    echo "xdebug.client_host=host.docker.internal" >> /etc/php/${PHP_VERSION}/cli/php.ini && \
    echo "xdebug.client_port=9003" >> /etc/php/${PHP_VERSION}/cli/php.ini && \
    echo "xdebug.log=/var/log/xdebug.log" >> /etc/php/${PHP_VERSION}/cli/php.ini && \
    echo "xdebug.idekey = PHPSTORM" >> /etc/php/${PHP_VERSION}/cli/php.ini

# Node.js
RUN apt install -y curl
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs
RUN npm install puppeteer --location=global && npx puppeteer browsers install chrome

# Git
RUN apt install -y git

# Network utils
RUN apt install -y net-tools iproute2 iputils-ping

WORKDIR /home/dev/projects
