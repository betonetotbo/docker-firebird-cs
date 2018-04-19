FROM pataquets/xinetd:xenial
ENV FBURL=https://github.com/FirebirdSQL/firebird/releases/download/R2_5_8/FirebirdCS-2.5.8.27089-0.amd64.tar.gz
ADD changepwd.sh changepwd.sh
RUN apt-get update && \
    apt-get install -qy --no-install-recommends \
        ca-certificates \
        nano \
        curl && \
    mkdir -p /firebird && \
    cd /firebird && \
    curl -L -o firebird.tar.gz -L "${FBURL}" && \
    tar --strip=1 -xf firebird.tar.gz && \
    /firebird/install.sh -silent && \
    rm -rf /firebird && \
    apt-get purge -qy --auto-remove \
        ca-certificates \
        curl && \
    chmod +x /changepwd.sh

RUN mkdir /data && chown firebird:firebird /data
VOLUME ["/data"]

EXPOSE 3050/tcp

ADD entrypoint.sh entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]