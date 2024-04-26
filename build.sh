#!/bin/bash

#set -e
BEAT="${1:-filebeat}"
ARCH="${2:-armv7l}"
TAG="${3}"

if [[ -z ${TAG} || ${TAG} == "master" ]] ; then
    TAG="v8.11.4"
    echo "Using default tag(${TAG})"
fi

VERSION="${TAG:1}"
SRC=$(pwd)

echo "Setup"

unset GOROOT
export GOPATH=$(pwd)/go/project
export PATH="/usr/local/go/bin:${GOPATH}/bin:${PATH}"
mkdir -p "${GOPATH}"

go version
go tool dist list | grep linux

if [[ ! -d beats ]] ; then
    echo "Cloning elastic/beats git tag(${TAG})"
    git clone --quiet --single-branch --branch="${TAG}" --depth=1 "https://github.com/elastic/beats.git"
    cd "${SRC}/beats"
    git checkout --quiet --detach "${TAG}"
    git describe --tags
fi

set -e

echo "Building(${BEAT})"

rm -rf "${GOPATH}/bin"
cd "${SRC}/beats/${BEAT}"
env GOOS=linux GOARCH=arm go install -v -a ./...

echo "Patching package"

SRC_ARCHIVE="${BEAT}-${VERSION}-linux-arm64"
DEST_ARCHIVE="${BEAT}-${VERSION}-linux-${ARCH}"

echo "${SRC_ARCHIVE} --> ${DEST_ARCHIVE}"

cd "${SRC}"
wget -q -N "https://artifacts.elastic.co/downloads/beats/${BEAT}/${SRC_ARCHIVE}.tar.gz"
tar -xf "${SRC_ARCHIVE}.tar.gz"
mv "${SRC_ARCHIVE}" "${DEST_ARCHIVE}"
cp -f "${GOPATH}/bin/linux_arm/${BEAT}" "${DEST_ARCHIVE}/${BEAT}"
tar -czf "${DEST_ARCHIVE}.tar.gz" "${DEST_ARCHIVE}"