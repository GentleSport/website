FROM stackbrew/ubuntu:14.04

RUN apt-get update && apt-get install php5 php5-mysql -y

#RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load

#COPY Dockerfiles/010-default.conf /etc/apache2/sites-enabled/000-default.conf

ADD . /code