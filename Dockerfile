FROM anzaxyz/agave:v2.0.21

# Install dependencies
RUN apt-get update && \
    apt-get install --no-install-recommends rustc curl jq ca-certificates librust-curl+openssl-probe-dev -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# Download and unpack yellowstone-grpc (solana geyser plugin)
RUN mkdir -p /opt/yellowstone-grpc && \
    curl -L -o /tmp/yellowstone-grpc.tar.bz2 \
      "https://github.com/rpcpool/yellowstone-grpc/releases/download/v3.2.2+solana.2.0.21/yellowstone-grpc-geyser-release-x86_64-unknown-linux-gnu.tar.bz2" && \
    tar -xjf /tmp/yellowstone-grpc.tar.bz2 -C /opt/yellowstone-grpc --strip-components=1 && \
    rm /tmp/yellowstone-grpc.tar.bz2
