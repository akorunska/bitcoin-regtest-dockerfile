# Dockerfile must start with a FROM instruction
# FROM instruction specifies the Base Image from which you are building
# FROM <image>[:<tag>]
FROM ubuntu:16.04

# Install bitcoind from PPA
RUN apt-get update
RUN apt-get install --yes software-properties-common
RUN apt-get install --yes wget git

RUN git clone https://github.com/bitcoin/bitcoin bitcoin
WORKDIR /bitcoin
RUN git checkout v0.21.0

# clone and make bitcoin
RUN apt-get install --yes build-essential libtool autotools-dev automake pkg-config bsdmainutils python3
RUN apt-get install --yes libevent-dev libboost-dev libboost-system-dev libboost-filesystem-dev libboost-test-dev
RUN apt-get install --yes libsqlite3-dev
RUN sh contrib/install_db4.sh $(pwd)
RUN export BDB_PREFIX=$(pwd)/db4
RUN ./autogen.sh
RUN ./configure BDB_LIBS="-L${BDB_PREFIX}/lib -ldb_cxx-4.8" BDB_CFLAGS="-I${BDB_PREFIX}/include"
RUN make && make install


# copy bitcoin.conf
ADD . /.bitcoin
    
RUN bitcoind -regtest -daemon

# There can only be one CMD instruction in a Dockerfile
# CMD provides defaults for an executing container
# Drop user into bash shell by default
# CMD ["/bin/bash"]