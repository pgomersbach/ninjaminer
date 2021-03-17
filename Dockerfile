FROM alpine:latest

RUN apk add --no-cache git make cmake libstdc++ gcc g++ automake libtool autoconf linux-headers && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/Bendr0id/xmrigCC.git && \
        cd xmrigCC && \
        cd scripts && \
        ./build_deps.sh && \
        cd .. && \
        cmake . -DWITH_ZLIB=ON -DXMRIG_DEPS=scripts/deps -DBUILD_STATIC=ON && \
        make

COPY Dockerfile /Dockerfile

COPY config.json /xmrigCC/config.json

ENTRYPOINT  ["/xmrigCC/xmrigDaemon"]
