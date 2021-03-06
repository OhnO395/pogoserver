FROM ubuntu:latest
MAINTAINER Neverlock
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -qq mysql-server mysql-client -y && apt-get upgrade -y && apt-get dist-upgrade -y && apt-get install apt-utils nano build-essential curl lsb-release openssl libssl-dev sudo python python-dev python3 python3-dev pkg-config autoconf automake libtool curl make g++ unzip vim -y
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN apt-get install -y nodejs git
RUN git clone --recursive https://github.com/google/protobuf.git
RUN cd /protobuf && ./autogen.sh && ./configure && make && make check && make install && ldconfig
RUN cd /
RUN /usr/bin/mysqld_safe &
RUN git clone --recursive https://github.com/maierfelix/POGOserver.git
RUN chmod +x /POGOserver/run-linux.sh
RUN cp /POGOserver/cfg.js.example /POGOserver/cfg.js
WORKDIR /POGOserver
RUN sed -i -e 's/"USERNAME"/"user@gmail.com"/g' cfg.js
RUN sed -i -e 's/"PASSWORD"/"password"/g' cfg.js
COPY script.sh / 
EXPOSE 80
EXPOSE 3306
EXPOSE 3000
CMD ["/script.sh"]
