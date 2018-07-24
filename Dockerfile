FROM azmo/base:ubuntu-latest
LABEL maintainer="Gordon Schulz <gordon.schulz@gmail.com>"

RUN set -x && \
        curl -o /tmp/parsec.deb \
        https://s3.amazonaws.com/parsec-build/package/parsec-linux.deb && \
        apt-get update && apt-get install -y /tmp/parsec.deb && \
        rm -f /tmp/parsec.deb && \
        apt-get -y install libva2 libva-x11-2 i965-va-driver pulseaudio && \
        apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PULSE_SERVER /run/pulse/native
WORKDIR /home/parsec

COPY ./rootfs /
CMD ["/usr/local/bin/parsec"]
