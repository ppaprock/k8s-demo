#!/bin/bash

SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPTPATH

CMD="kubectl create -f "
YML_LOC="../kubernetes"

$CMD $YML_LOC/pv-claim.yml && \
$CMD $YML_LOC/secrets.yml && \
$CMD $YML_LOC/db.yml && \
$CMD $YML_LOC/db-service.yml && \
$CMD $YML_LOC/web.yml && \
$CMD $YML_LOC/web-service.yml
