FROM debian:stretch

RUN \
    apt-get update && \
    apt-get install --no-install-recommends -y mldonkey-server && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/log/mldonkey && \
    rm /var/lib/mldonkey/*

USER mldonkey
ENV MLDONKEY_DIR /var/lib/mldonkey
VOLUME /var/lib/mldonkey
VOLUME /mnt/mldonkey_tmp
VOLUME /mnt/mldonkey_completed
EXPOSE 4001 4080 20562 20566/udp 6209 6209/udp 16965/udp 3617/udp 6881 6882
ADD entrypoint.sh /
CMD /entrypoint.sh
