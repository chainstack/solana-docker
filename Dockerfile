FROM solanalabs/solana:v1.14.16

RUN apt-get update && \
    apt-get install --no-install-recommends rustc curl jq ca-certificates librust-curl+openssl-probe-dev/stable -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean
