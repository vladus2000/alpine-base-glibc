FROM alpine:latest
MAINTAINER vladus2000 <docker@matt.land>

ENV ENV=/.profile
ENV STARTUP_CMD="sleep 1h"
ENV GLIBC_VERSION 2.30-r0

COPY shiz/ /

RUN \
	apk add --update curl && \
	curl -Lo /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
	curl -Lo glibc.apk "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" && \
	curl -Lo glibc-bin.apk "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" && \
	apk add glibc-bin.apk glibc.apk && \
	/usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib && \
	echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
	apk del curl && \
	ln -s /.bashrc /root/. && \
	cp /.bashrc /.profile && \
	chmod +x /*.sh && \
	sleep 1 && \
	/update.sh && \
	rm -rf glibc.apk glibc-bin.apk /var/cache/apk/*

CMD /bin/ash -c /startup.sh

