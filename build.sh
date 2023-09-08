#!/bin/bash

export BIRD_VERSION=2.13

rm -rf out
mkdir out

DOCKER_BUILDKIT=1 docker build -o out/bird-$BIRD_VERSION/mips mips --build-arg BIRD_VERSION=${BIRD_VERSION}
DOCKER_BUILDKIT=1 docker build -o out/bird-$BIRD_VERSION/mipsel mipsel --build-arg BIRD_VERSION=${BIRD_VERSION}

cd out && tar -czvf bird-$BIRD_VERSION.tar.gz bird-$BIRD_VERSION/ && cd ..
