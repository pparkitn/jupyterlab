Build v-machine using google console
Stop It

Download gcloud
https://cloud.google.com/sdk/docs/downloads-versioned-archives
https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-342.0.0-windows-x86_64-bundled-python.zip

\google-cloud-sdk\install.bat
.\google-cloud-sdk\bin\gcloud init


Start VM


Connect to VM
gcloud compute ssh sxm-peter-1 --ssh-flag="-L 8888:127.0.0.1:8888"

# Install Docker 
sudo apt-get update
sudo apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg \
     lsb-release

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Start Jupyter Lab
sudo docker run -p 8888:8888 -v $(pwd):/home pparkitn/jupyterlab jupyter-lab --ip 0.0.0.0 --allow-root --no-browser --NotebookApp.token=''