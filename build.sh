#!/bin/sh

docker build "${0%/*}" \
  --tag=alefchak/snapraid-scheduled:latest
