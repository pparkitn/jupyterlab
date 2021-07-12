# Setup gcloud

## Setup Notebook
- Build v-machine using google console
- Change disk to 50 GB

## Generate SSH Key
```
ssh-keygen -t rsa -f google_keyfile -C username
```

## ADD Key To Metadata
- Paste what is inside google_keyfile.pub into the metadata on Compute Engine


## Connect To VM Box
'''
ssh -i google_keyfile -o UserKnownHostsFile=/dev/null -o CheckHostIP=no -o StrictHostKeyChecking=no username@IP
'''


# Install Docker
```
sudo apt-get update
```

```
sudo apt-get update
sudo apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg \
     lsb-release
```
```
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

```
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
```

```
sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
```

```
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

# Start Jupyter Lab: Python
```
sudo docker run -p 8888:8888 -v $(pwd):/home pparkitn/jupyterlab jupyter-lab --ip 0.0.0.0 --allow-root --no-browser --NotebookApp.token=''
```

# Start Jupyter Lab:  Spark
```
export GID=1001
cat > docker-compose.yaml << EOF
version: '3'
services:
  spark:
    image: jupyter/pyspark-notebook
    hostname: docker.w261
    privileged: true
    user: root
    environment:
      - NB_USER=$USER
      - CHOWN_HOME=yes
      - GRANT_SUDO=yes
      - NB_UID=$UID
      - NB_GID=$GID
    command: bash -c "start.sh jupyter lab --ServerApp.token='' --ServerApp.authenticate_prometheus=False --ServerApp.port=8889"
    ports:
      - "8889:8889"
      - "4040:4040"
    tty: true
    stdin_open: true
    volumes:
      - .:/home/$USER
```

```
docker-compose up
```
