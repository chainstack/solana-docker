FROM anzaxyz/agave:v2.1.13

# Install build dependencies
RUN apt-get update && \
    apt-get install --no-install-recommends \
    rustc \
    curl \
    jq \
    ca-certificates \
    librust-curl+openssl-probe-dev \
    build-essential \
    wget \
    zlib1g-dev \
    -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# Build and install OpenSSL 1.1
RUN cd /tmp && \
    wget https://www.openssl.org/source/old/1.1.1/openssl-1.1.1q.tar.gz && \
    tar xzf openssl-1.1.1q.tar.gz && \
    cd openssl-1.1.1q && \
    ./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib && \
    make && \
    make install && \
    ln -s /usr/local/ssl/lib/libssl.so.1.1 /usr/lib/libssl.so.1.1 && \
    ln -s /usr/local/ssl/lib/libcrypto.so.1.1 /usr/lib/libcrypto.so.1.1 && \
    echo "/usr/local/ssl/lib" > /etc/ld.so.conf.d/openssl-1.1.1.conf && \
    ldconfig && \
    cd / && \
    rm -rf /tmp/openssl-1.1.1q*

RUN ldconfig -v | grep ssl && \
    ls -la /usr/lib/libssl.so.1.1 && \
    ls -la /usr/lib/libcrypto.so.1.1

ENV LD_LIBRARY_PATH=/usr/local/ssl/lib

# Download and unpack yellowstone-grpc (solana geyser plugin)
RUN mkdir -p /opt/yellowstone-grpc && \
    curl -L -o /tmp/yellowstone-grpc.tar.bz2 \
      "https://github.com/rpcpool/yellowstone-grpc/releases/download/v5.0.0+solana.2.1.15/yellowstone-grpc-geyser-release-x86_64-unknown-linux-gnu.tar.bz2" && \
    tar -xjf /tmp/yellowstone-grpc.tar.bz2 -C /opt/yellowstone-grpc --strip-components=1 && \
    rm /tmp/yellowstone-grpc.tar.bz2
