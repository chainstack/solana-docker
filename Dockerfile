FROM solanalabs/solana:v1.9.29

RUN apt-get update && \
    apt-get install --no-install-recommends rustc curl jq -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean
