#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

echo "$0: building the package"

VARIANT=$1
ARTIFACTS_FOLDER=$2

sudo apt-get -y install dpkg-dev

sudo apt-get install -y \
    build-essential \
    libssl-dev \
    uuid-dev \
    libgpgme11-dev \
    squashfs-tools \
    libseccomp-dev \
    wget \
    pkg-config \
    git \
    cryptsetup \
    libglib2.0-dev \
    libfuse3-dev

echo "$0: building the package into '$ARTIFACTS_FOLDER'"

mkdir -p $ARTIFACTS_FOLDER

make deb

mv build/*.deb $ARTIFACTS_FOLDER
