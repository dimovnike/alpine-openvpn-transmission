FROM dimovnike/alpine-openvpn

MAINTAINER nikolay dimov 

RUN apk add --update transmission-daemon speedtest-cli speedometer  && rm  -rf /tmp/* /var/cache/apk/*

EXPOSE 9091

ADD supervisord-transmission.conf /etc/supervisor/conf.d/
ADD run-transmission.sh /usr/local/bin/

