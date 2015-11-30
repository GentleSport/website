# gentlsport:local
FROM php:5.6-apache

MAINTAINER Hayk Avetisyan

RUN a2enmod rewrite

# install the PHP extensions we need
RUN apt-get update && apt-get install -y \
  vim \
  less \
  wget \
  libmcrypt-dev libldap2-dev libpng12-dev libjpeg-dev && rm -rf /var/lib/apt/lists/* \
  && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
  && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
  && docker-php-ext-configure mcrypt \
  && docker-php-ext-install gd \
  && docker-php-ext-install ldap \
  && docker-php-ext-install mcrypt \
  && docker-php-ext-install mysqli

# install some pear channels and packages
RUN pear channel-update pear.php.net && \
    pear upgrade pear && \
    pear channel-discover zend.googlecode.com/svn && \
    pear install Zend/Zend-1.12.7 

WORKDIR /website

# temporary install mysql-client
RUN apt-get update && apt-get install -y \
    mysql-client

RUN curl http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz > ioncube_loaders_lin_x86-64.tar.gz && \
    tar -xvzf ioncube_loaders_lin_x86-64.tar.gz

COPY ./templates/license.txt /website/license.txt

COPY ./templates/htaccess /website/.htaccess

COPY ./templates/htaccess_install /website/install/.htaccess

COPY ./templates/php.ini /usr/local/etc/php/php.ini

COPY ./templates/apache2.conf /etc/apache2/apache2.conf

COPY ./templates/supervisord.conf /etc/supervisor/supervisord.conf

CMD ["/usr/local/bin/supervisord","-c","/etc/supervisor/supervisord.conf"]

EXPOSE 80 443