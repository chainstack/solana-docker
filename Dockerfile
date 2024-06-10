FROM anzaxyz/agave:v1.18.15

RUN apt-get update && \
    apt-get install --no-install-recommends rustc curl jq ca-certificates librust-curl+openssl-probe-dev -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean
