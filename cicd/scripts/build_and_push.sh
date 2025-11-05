#!/bin/bash
set -e
docker build -t $1:latest $2
docker push $1:latest

