FROM debian:jessie

RUN apt-get update \ 
&& apt-get clean \
&& apt-get install -y wget unzip ca-certificates --no-install-recommends


RUN cd /opt \
&& wget https://github.com/sirensolutions/kibi/releases/download/0.3.2/kibi-0.3.2-linux-x64.zip \
&& unzip kibi-0.3.2-linux-x64.zip \
&& ln -s kibi-0.3.2-linux-x64 kibi

COPY entrypoint.sh /opt/

RUN chmod 755 /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]

EXPOSE 5606
