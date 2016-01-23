FROM stackbrew/ubuntu:14.04

MAINTAINER Hayk Avetisyan

# set env variable for avoiding  TERM errors
ENV TERM xterm-256color
ENV HTTPD_VERSION 2.2.31
ENV HTTPD_BZ2_URL https://www.apache.org/dist/httpd/httpd-$HTTPD_VERSION.tar.bz2

RUN apt-get update 

RUN apt-get install -y php5 php5-mysql links

#RUN apt-get install -y php5-common php5-cli php5-fpm

RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load

COPY Dockerfiles/010-default.conf /etc/apache2/sites-enabled/000-default.conf

ADD . /code

COPY Dockerfiles/httpd-foreground /usr/local/bin/

#ENTRYPOINT service apache2 start

CMD ["httpd-foreground"]