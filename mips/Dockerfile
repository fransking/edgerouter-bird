FROM debian:stretch-slim AS build

RUN dpkg --add-architecture mips && \
	apt-get update && \
	apt-get -y install \
	build-essential \
	dpkg-cross \
	g++-mips-linux-gnu \
	git \
	bison \
	flex \
	wget && \
	rm -rf /var/lib/apt/lists/*

ENV CROSSCOMPILE="mips-linux-gnu"
ARG BIRD_VERSION 

RUN wget https://bird.network.cz/download/bird-$BIRD_VERSION.tar.gz --no-check-certificate && \
	tar xzfv bird-$BIRD_VERSION.tar.gz && \
	cd bird-$BIRD_VERSION && \	
	./configure --host mips-linux-gnu --prefix=/config --sysconfdir=/config --runstatedir=/run --disable-client --disable-mpls_kernel && \
	make

FROM scratch AS export

ARG BIRD_VERSION

COPY --from=build /bird-$BIRD_VERSION/bird .
COPY --from=build /bird-$BIRD_VERSION/birdcl .
