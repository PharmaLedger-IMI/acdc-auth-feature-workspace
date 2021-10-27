#!/bin/bash
UCNAME="auth-feature-workspace"

docker run --detach \
    --hostname $UCNAME \
    --publish 8080:8080 \
    --name $UCNAME \
    --restart always \
    pharmaledger/$UCNAME
