#!/bin/bash

SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPTPATH

cd .. && \
cd db && \
./build.sh && \
cd .. && \
cd service && \
./build.sh && \
cd .. && \
docker-compose up -d
