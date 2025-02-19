#!/usr/bin/env sh

BUILD_TYPE=$1
VERSION=$2

echo "[INFO] build type '${BUILD_TYPE}'; version '${VERSION}'"


if [ -z "${BUILD_TYPE}" ]; then
    echo "[ERROR] build type or version empty; Usage: ./build.sh <build-type> <version>"
    exit 1
fi

apt-get update
apt-get install --yes build-essential libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev wget

wget -O tengine-${VERSION}.tar.gz https://codeload.github.com/alibaba/tengine/tar.gz/refs/tags/${VERSION}
tar -xzf tengine-${VERSION}.tar.gz

cd tengine-${VERSION}

if [ "${BUILD_TYPE}" = "simple" ]; then
    ./configure
fi

if [ "${BUILD_TYPE}" = "min" ]; then
    ./configure --without-http_rewrite_module --without-http_gzip_module --without-http_proxy_module
fi

make -j$(nproc)
make install
