#!/bin/bash

rm -rf build.log


docker build -t mssql2019-custom -f linux/dockerfile . > build.log 2>&1