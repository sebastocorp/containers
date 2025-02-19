#!/usr/bin/env sh

BUILD_TYPE=$1

echo "[INFO] build type '${BUILD_TYPE}'"


if [ -z "${BUILD_TYPE}" ]; then
    echo "[ERROR] build type empty; Usage: ./deps.sh <build-type>"
    exit 1
fi

apt-get update

if [ "${BUILD_TYPE}" = "simple" ]; then
    apt-get install --yes libpcre3 libpcre3-dev libssl3 libssl-dev
fi

if [ "${BUILD_TYPE}" = "min" ]; then
    apt-get install --yes libpcre3 libpcre3-dev libssl3 libssl-dev
fi
