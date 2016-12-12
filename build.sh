#!/bin/bash

#
#
BVERSION=6.4.0.GA
VERSION=6.4.0
IMAGE="1000kit/jboss-bpms"

cd "$( dirname "${BASH_SOURCE[0]}" )"
pwd

if [[ ! -z "${EAP_DOWNLOAD_URL}" ]]; then	
	echo "use provided Download URL"
else
	if [ ! -e install/jboss-bpmsuite-${BVERSION}-deployable-eap7.x.zip ]; then
		echo "!! Download BPM Suite ${BVERSION} deployable eap7 in install/jboss-bpmsuite-${BVERSION}-deployable-eap7.x.zip"
		exit
	fi
	
	LOCIP=`hostname -I | cut -d' ' -f1`
	echo $LOCIP
	
	python3 -m http.server --bind ${LOCIP} 8000 &
	HTTP_PID=$!
	
	BPMS_DOWNLOAD_URL="http://${LOCIP}:8000/install"	
	
fi
sleep 10
#curl -L ${BPMS_DOWNLOAD_URL}/jboss-bpmsuite-6.4.0.GA-deployable-eap7.x.zip > /tmp/tt
#exit
echo "build jboss BPM Suite standalone image"
docker build --build-arg BPMS_DOWNLOAD_URL="${BPMS_DOWNLOAD_URL}" --force-rm -t ${IMAGE}:${VERSION} .

echo "tag image with version ${VERSION}"
docker tag ${IMAGE}:${VERSION} ${IMAGE}:latest


if [ ! -z ${HTTP_PID} ]; then
	echo "Stop HTTP Server ${HTTP_PID}"
	kill -9 ${HTTP_PID}
fi


#end
