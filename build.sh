#!/bin/bash

#
#
BVERSION=6.3.0.GA
VERSION=6.3.0
IMAGE="1000kit/jboss-bpms"

cd "$( dirname "${BASH_SOURCE[0]}" )"
pwd

if [ ! -e install/jboss-bpmsuite-${BVERSION}-deployable-eap6.x.zip ]; then
	echo "!! Download BPM Suite ${BVERSION} deployable eap6 in install/jboss-bpmsuite-${BVERSION}-deployable-eap6.x.zip"
	exit
fi

echo "build jboss BPM Suite standalone image"
docker build --force-rm -t ${IMAGE}:${VERSION} .
echo "tag image with version ${VERSION}"
docker tag ${IMAGE}:${VERSION} ${IMAGE}:latest

#end
