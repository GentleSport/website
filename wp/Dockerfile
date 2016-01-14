FROM stackbrew/ubuntu:14.04

RUN apt-get update 

RUN apt-get install -y php5 php5-mysql 

#RUN apt-get install -y php5-common php5-cli php5-fpm

RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load

COPY Dockerfiles/010-default.conf /etc/apache2/sites-enabled/000-default.conf

ADD . /code

CMD service apache2 start