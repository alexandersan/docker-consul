FROM 		progrium/busybox
MAINTAINER 	Jeff Lindsay <progrium@gmail.com>

RUN opkg-install curl bash ca-certificates \
 && curl -O https://dl.bintray.com/mitchellh/consul/0.4.1_linux_amd64.zip \
         -O https://dl.bintray.com/mitchellh/consul/0.4.1_web_ui.zip \
         -O https://get.docker.io/builds/Linux/x86_64/docker-1.5.0 \
 && cd /bin \
 && unzip /consul.zip \
 && chmod +x /bin/consul \
 && rm -f /consul.zip \
 && mkdir /ui \
 && cd /ui \
 && unzip /webui.zip \ 
 && rm /webui.zip \
 && mv /docker-1.5.0 /bin/docker \
 && chmod +x /bin/docker

ADD ./config /config/
ONBUILD ADD ./config /config/

ADD ./start /bin/start
ADD ./check-http /bin/check-http
ADD ./check-cmd /bin/check-cmd

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 8600 8600/udp
VOLUME ["/data"]

ENV SHELL /bin/bash
ENV SERVICE_IGNORE yes

ENTRYPOINT ["/bin/start"]
CMD []
