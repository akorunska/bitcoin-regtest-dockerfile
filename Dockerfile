# Dockerfile must start with a FROM instruction
# FROM instruction specifies the Base Image from which you are building
# FROM <image>[:<tag>]
FROM ubuntu:16.04

# Install dependencies
RUN apt-get update
RUN apt-get install --yes software-properties-common
RUN apt-get install --yes wget git

RUN git clone https://github.com/bitcoin/bitcoin bitcoin
WORKDIR /bitcoin
RUN git checkout v0.21.0

# clone and make bitcoin
RUN apt-get install --yes build-essential libtool autotools-dev automake pkg-config bsdmainutils python3
RUN apt-get install --yes libevent-dev libboost-dev libboost-system-dev libboost-filesystem-dev libboost-test-dev libboost-all-dev
# libboost-thread-dev libboost-all-dev
RUN apt-get install --yes libsqlite3-dev
RUN sh contrib/install_db4.sh $(pwd)
RUN ./autogen.sh
RUN ./configure BDB_LIBS="-L$(pwd)/db4/lib -ldb_cxx-4.8" BDB_CFLAGS="-I$(pwd)/db4/include"
RUN make
RUN make install


# copy bitcoin.conf
ADD . /root/.bitcoin
    
# RUN bitcoind -regtest -daemon
