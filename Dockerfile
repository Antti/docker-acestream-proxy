# Set the base image to use to Ubuntu
FROM ubuntu:16.04

MAINTAINER Andrii Dmytrenko <refresh.xss@gmail.com>

RUN apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get install -y wget supervisor unzip ca-certificates

RUN echo 'deb http://repo.acestream.org/ubuntu/ trusty main' > /etc/apt/sources.list.d/acestream.list &&\
    wget -q -O - http://repo.acestream.org/keys/acestream.public.key | apt-key add - &&\
    DEBIAN_FRONTEND=noninteractive apt-get update -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y acestream-engine vlc-nox python-gevent python-psutil git

RUN mkdir -p /var/run/sshd && mkdir -p /var/log/supervisor

RUN adduser --disabled-password --gecos "" tv

RUN git clone https://github.com/AndreyPavlenko/aceproxy.git /home/tv/aceproxy-master
RUN echo 'root:password' | chpasswd

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 22 8000 62062

ENTRYPOINT ["/start.sh"]
