#!/bin/bash

rm -f .env

# docker by default
docker-compose up --no-log-prefix 2>/dev/null | grep "ORIGIN" | sed -E "s/^.*=//g"
# cmd overrides everything
ORIGIN=cmd docker-compose up --no-log-prefix 2>/dev/null | grep "ORIGIN" | sed -E "s/^.*=//g"
# cmd if exposed to docker run
ORIGIN=cmd docker run --rm -e ORIGIN alpine printenv | grep "ORIGIN" | sed -E "s/^.*=//g"
# make overrides the docker default
make docker
# cmd overrides everything
ORIGIN=cmd make docker
# make by default
make bash
# cmd overrides everything
ORIGIN=cmd make bash

echo "ORIGIN=dotenv" >> .env

# dotenv overrides the defaults
docker-compose up --no-log-prefix 2>/dev/null | grep "ORIGIN" | sed -E "s/^.*=//g"
# dotenv if docker includes .env
docker run --rm --env-file .env alpine printenv | grep "ORIGIN" | sed -E "s/^.*=//g"
# dotenv overrides the defaults
make docker
# cmd overrides everything
ORIGIN=cmd make docker
# dotenv overrides the defaults
make bash
# cmd overrides everything
ORIGIN=cmd make bash
