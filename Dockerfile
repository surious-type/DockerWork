FROM ubuntu:22.04

# SSH
RUN apt update && apt install  openssh-server sudo -y
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 dev 
RUN echo 'dev:qwerty-123' | chpasswd
RUN service ssh start
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]

# RUN sudo apt upgrade -y;

# PHP
# RUN sudo apt install -y software-properties-common;
# RUN sudo add-apt-repository ppa:ondrej/php;
# RUN sudo apt-get install php8.1; sudo update-alternatives --set php /usr/bin/php8.1; sudo apt-get update;
# RUN sudo apt-get -y install php8.1-xml;
# RUN sudo apt-get -y install php8.1-gd;
# RUN sudo apt-get -y install php8.1-intl;
# RUN sudo apt-get -y install php8.1-xsl;
# RUN sudo apt-get -y install php8.1-ldap;
# RUN sudo apt-get -y install php8.1-pgsql;

# NODEJS
# RUN sudo apt install -y curl;
# RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash;
# RUN source ~/.bashrc
# RUN export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# RUN [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# RUN nvm install 20;
# RUN sudo apt -y install npm; sudo apt -y install nodejs;

SHELL ["/bin/bash", "--login", "-i", "-c"]
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
RUN source /root/.bashrc && nvm install 20
SHELL ["/bin/bash", "--login", "-c"]
RUN npm -v;
RUN node -v;

# NETWORK
# RUN apt install -y net-tools
# RUN apt install -y iproute2
# RUN apt install -y iputils-ping
