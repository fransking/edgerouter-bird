FROM debian:stretch-slim AS build

# Update stretch repositories
RUN sed -i -e 's/deb.debian.org/archive.debian.org/g' \
           -e 's|security.debian.org|archive.debian.org/|g' \
           -e '/stretch-updates/d' /etc/apt/sources.list

RUN apt-get update

RUN dpkg --add-architecture mipsel && \
	apt-get update && \
	apt-get -y install \
	build-essential \
	dpkg-cross \
	g++-mipsel-linux-gnu \
	git \
	bison \
	flex \
	wget && \
	rm -rf /var/lib/apt/lists/*

ENV CROSSCOMPILE="mipsel-linux-gnu"
ARG BIRD_VERSION 

RUN wget https://bird.network.cz/download/bird-$BIRD_VERSION.tar.gz --no-check-certificate && \
	tar xzfv bird-$BIRD_VERSION.tar.gz && \
	cd bird-$BIRD_VERSION && \	
	./configure --host mipsel-linux-gnu --prefix=/config --sysconfdir=/config --runstatedir=/run --disable-client --disable-mpls_kernel && \
	make

FROM scratch AS export

ARG BIRD_VERSION
WORKDIR /

COPY --from=build /bird-$BIRD_VERSION/bird .
COPY --from=build /bird-$BIRD_VERSION/birdcl .
