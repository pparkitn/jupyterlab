#!/bin/bash

docker build -t myimage .
docker tag myimage pparkitn/jupyterlab
docker login
docker push pparkitn/jupyterlab
sudo docker run -p 8888:8888 -v $(pwd):/home pparkitn/jupyterlab jupyter-lab --ip 0.0.0.0 --allow-root --no-browser --NotebookApp.token=''