#!/bin/bash

docker build -t pharmaledger/auth-feature-workspace "$(dirname $(readlink -f $0))" --no-cache --network host
