#!/bin/bash

set -e

cp ../Dockerfile ../*.rb ./

IMAGE_ID=`docker build --quiet .`

# Don’t add -t to the below; it causes lines to be output with CRLF separators
docker run --rm -e "ORG=$ORG" -e "TOKEN=$TOKEN" $IMAGE_ID ruby _list.rb
