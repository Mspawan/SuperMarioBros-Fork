FROM accetto/ubuntu-vnc-xfce-g3:latest

USER root

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    wine64 wine32 winbind cabextract wget xvfb x11vnc winetricks && \
    rm -rf /var/lib/apt/lists/*

COPY bin/Debug/ /opt/supermario/
COPY start.sh /opt/start.sh
RUN chmod +x /opt/start.sh

CMD ["/opt/start.sh"]
