FROM ubuntu:18.04
LABEL maintainer="Victor Mongi"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y gnupg tzdata vim\
    && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get install -y software-properties-common \
 && apt-add-repository ppa:ondrej/php
RUN apt-get update

RUN apt-get install -y \
    build-essential \
    curl \
    libaio1 \
    tdsodbc \
    unixodbc \
    unzip \
    php5.6 \
    php5.6-bcmath \
    php5.6-bz2 \
    php5.6-cgi \
    php5.6-cli \
    php5.6-common \
    php5.6-curl \
    php5.6-dba \
    php5.6-dev \
    php5.6-enchant \
    php5.6-gd \
    php5.6-gmp \
    php5.6-imap \
    php5.6-interbase \
    php5.6-intl \
    php5.6-json \
    php5.6-ldap \
    php5.6-mbstring \
    php5.6-mcrypt \
    php5.6-mysql \
    php5.6-odbc \
    php5.6-opcache \
    php5.6-pgsql \
    php5.6-phpdbg \
    php5.6-pspell \
    php5.6-readline \
    php5.6-recode \
    php5.6-soap \
    php5.6-sqlite3 \
    php5.6-sybase \
    php5.6-tidy \
    php5.6-xml \
    php5.6-xmlrpc \
    php5.6-xsl \
    php5.6-zip \
    php-memcached \
    php-memcache \
    php-apcu \
    libpcre3-dev \
    libxml2-dev \
    vim \
    apt-transport-https

RUN apt-get -y install nginx supervisor php5.6-fpm

RUN apt-get update \
    && mkdir /run/php \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && echo "daemon off;" >> /etc/nginx/nginx.conf
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["supervisord"]

COPY ./default /etc/nginx/sites-available/default
