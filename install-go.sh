#!/bin/bash
GO_VERSION=${1:-1.20.11}
GO_ARCH=${2:amd64}
FORCE=${3}

if [[ -n ${FORCE} ]] ; then
    echo "Removing go"
    rm -r /usr/local/go
fi

if [[ ! -d /usr/local/go ]] ; then
    wget -q -N "https://dl.google.com/go/go${GO_VERSION}.linux-${GO_ARCH}.tar.gz"
    tar -xf "go${GO_VERSION}.linux-${GO_ARCH}.tar.gz"
    mv go /usr/local/go
fi

export PATH=/usr/local/go/bin:${PATH}
go version
