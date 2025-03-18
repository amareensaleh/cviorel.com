#!/bin/bash

rm -rf build.log

# Regular build
#docker build -t mssql2019-custom -f linux/dockerfile . > build.log 2>&1

# Using emulation since apple M3 is arm64
docker buildx build --no-cache --platform linux/amd64 -t mssql2019-custom -f linux/dockerfile .