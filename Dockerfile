FROM ubuntu:22.04

# SSH
RUN apt update && apt install  openssh-server sudo -y
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 dev 
RUN echo 'dev:qwerty-123' | chpasswd
RUN service ssh start
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]

ENV PHP_VERSION="8.2"

# PHP
RUN sudo apt install -y software-properties-common;
RUN sudo add-apt-repository ppa:ondrej/php;
RUN DEBIAN_FRONTEND=noninteractive TZ=Europe/Moscow apt-get -y install tzdata
RUN sudo apt-get -y install php${PHP_VERSION};
RUN sudo update-alternatives --set php /usr/bin/php${PHP_VERSION}; sudo apt-get update;
#RUN sudo apt-get -y -f install php${PHP_VERSION}*;
RUN sudo apt-get -y install php${PHP_VERSION}-xml;
RUN sudo apt-get -y install php${PHP_VERSION}-gd;
RUN sudo apt-get -y install php${PHP_VERSION}-intl;
RUN sudo apt-get -y install php${PHP_VERSION}-xsl;
RUN sudo apt-get -y install php${PHP_VERSION}-ldap;
RUN sudo apt-get -y install php${PHP_VERSION}-pgsql;
RUN sudo apt-get -y install php${PHP_VERSION}-zip;

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
RUN install-php-extensions xdebug
RUN echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.start_with_request = yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.client_port=9003" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.log=/var/log/xdebug.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.idekey = PHPSTORM" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN sudo apt-get -y install php${PHP_VERSION}-mbstring;
RUN sudo apt-get -y install php${PHP_VERSION}-json;
RUN sudo apt-get -y install php${PHP_VERSION}-curl;
RUN php -v;
RUN php -m;

# NODEJS
RUN sudo apt install -y curl;
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - &&\
    sudo apt-get install -y nodejs
RUN npm -v;
RUN node -v;
RUN npm install puppeteer --location=global
RUN npx puppeteer browsers install chrome

# GIT
RUN sudo apt -y install git
RUN git --version

# GITLAB-RUNNER
RUN curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
RUN sudo apt-get install gitlab-runner

# NETWORK
RUN apt install -y net-tools
RUN apt install -y iproute2
RUN apt install -y iputils-ping

# APACHE2
RUN apt install -y apache2
RUN apt install -y libapache2-mod-php${PHP_VERSION}
RUN a2enmod php${PHP_VERSION}
RUN a2enmod rewrite
