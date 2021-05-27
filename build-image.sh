#!/bin/bash

docker build -t myimage .
docker tag myimage pparkitn/jupyterlab
docker login
docker push pparkitn/jupyterlab