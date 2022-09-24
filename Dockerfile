FROM solanalabs/solana:v1.10.39

RUN apt-get update && \
    apt-get install --no-install-recommends rustc curl jq librust-curl+openssl-probe-dev/stable -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean
