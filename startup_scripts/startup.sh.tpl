#!/bin/bash

echo 'Acquire::ForceIPv4 "true";' | sudo tee /etc/apt/apt.conf.d/99force-ipv4

sudo -c export PORT

sudo echo 'PORT='${PORT}'' >>/etc/environment

sudo -c export INITIAL_IP

sudo echo 'INITIAL_IP='${INITIAL_IP}'' >>/etc/environment

sudo apt update && sudo apt upgrade -y

# Installing docker

sudo apt install ca-certificates curl gnupg -y

sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

sudo echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

sudo apt update && sudo apt upgrade -y

sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Clonning repos

sudo git clone "https://github.com/YapieRT/ion-organizer.git" /home/ubuntu/ion-organizer

sudo git clone "https://github.com/YapieRT/ion-organizer-api.git" /home/ubuntu/ion-organizer-api

sudo sleep 5

# Moving creds

sudo mv /home/ubuntu/db.js /home/ubuntu/ion-organizer-api/

# Setuping env variables

sudo sed -i 's/ENV REACT_APP_BACKEND_IP=/ENV REACT_APP_BACKEND_IP=http:\/\/'${INITIAL_IP}':'${PORT}'/g' /home/ubuntu/ion-organizer/Dockerfile

sudo sed -i 's/EXPOSE 8080/EXPOSE '${PORT}'/g' /home/ubuntu/ion-organizer-api/Dockerfile

sudo sed -i 's/ENV PORT=8080/ENV PORT='${PORT}'/g' /home/ubuntu/ion-organizer-api/Dockerfile

sudo sed -i 's/- 8080:8080/- '${PORT}':'${PORT}'/g' /home/ubuntu/docker-compose-stack.yaml

# Starting containers

cd /home/ubuntu

sudo docker build -t ion-organizer-api ion-organizer-api/.

sudo docker build -t ion-organizer-ui ion-organizer/.

sudo docker swarm init

sudo docker stack deploy -c docker-compose-stack.yaml ion-stack
