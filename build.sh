#!/bin/bash

#set -e
BEAT="${1:-filebeat}"
ARCH="${2:-armv7l}"
BRANCH="${3:-master}"
TYPE="${4:-branch}"

if [[ -n ${GITHUB_REF_NAME} ]] ; then
    BRANCH=${GITHUB_REF_NAME}
    echo "Using BRANCH(${BRANCH})"
fi

if [[ -n ${GITHUB_REF_TYPE} ]] ; then
    TYPE=${GITHUB_REF_TYPE}
    echo "Using GITHUB_REF_TYPE(${TYPE})"
fi

if [[ $TYPE != "tag" ]] ; then
    BRANCH="master"
    echo "Using default branch(${BRANCH})"
fi

echo "Branch(${BRANCH}) Type(${TYPE})"

VERSION="${BRANCH:1}"
SRC=$(pwd)

echo "Setup"

unset GOROOT
export GOPATH=$(pwd)/go/project
export PATH="/usr/local/go/bin:${GOPATH}/bin:${PATH}"
mkdir -p "${GOPATH}"

go version
go tool dist list | grep linux

if [[ ! -d beats ]] ; then
    echo "Cloning elastic/beats git branch(${BRANCH})"
    git clone --quiet --single-branch --branch="${BRANCH}" --depth=1 "https://github.com/elastic/beats.git"
    cd "${SRC}/beats"
    git checkout --quiet --detach "${BRANCH}"
    git describe --tags
fi

set -e

echo "Building(${BEAT})"

rm -rf "${GOPATH}/bin"
cd "${SRC}/beats/${BEAT}"
env GOOS=linux GOARCH=arm go install -v -a -ldflags "-s -w" ./...

if [[ $TYPE != "tag" ]] ; then
    #do not packe if not a tag
    ls -al ${GOPATH}/bin/linux_arm/${BEAT}
    exit 0
fi

echo "Patching package version(${VERSION})"

SRC_ARCHIVE="${BEAT}-${VERSION}-linux-arm64"
DEST_ARCHIVE="${BEAT}-${VERSION}-linux-${ARCH}"

echo "${SRC_ARCHIVE} --> ${DEST_ARCHIVE}"

cd "${SRC}"
wget "https://artifacts.elastic.co/downloads/beats/${BEAT}/${SRC_ARCHIVE}.tar.gz"
tar -xf "${SRC_ARCHIVE}.tar.gz"
mv "${SRC_ARCHIVE}" "${DEST_ARCHIVE}"
cp -f "${GOPATH}/bin/linux_arm/${BEAT}" "${DEST_ARCHIVE}/${BEAT}"
tar -czf "${DEST_ARCHIVE}.tar.gz" "${DEST_ARCHIVE}"