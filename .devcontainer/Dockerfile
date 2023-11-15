# Use the official lightweight Python image.
# https://hub.docker.com/_/python
FROM mcr.microsoft.com/devcontainers/python:0-3.10

# Allow statements and log messages to immediately appear in the Knative logs
ENV PYTHONUNBUFFERED True

#RUN apt-get -qq -y install curl
# Install OS level dependencies.
RUN apt update
RUN apt-get install -y sudo dnf lsb-release

# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux
RUN /usr/bin/curl -LO "https://dl.k8s.io/release/$(/usr/bin/curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN /usr/bin/sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
# remove local
RUN rm kubectl

# helm
RUN /usr/bin/curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
RUN /usr/bin/wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

#install apt get
RUN /usr/bin/wget -O- https://apt.releases.hashicorp.com/gpg | /usr/bin/sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(/usr/bin/lsb_release -cs) main" | /usr/bin/sudo tee /etc/apt/sources.list.d/hashicorp.list
RUN /usr/bin/sudo apt update -y && /usr/bin/sudo apt install terraform
RUN /usr/bin/sudo apt update -y && /usr/bin/sudo apt install dnsutils -y
# install project (python) dependencies for dev

# Add Docker's official GPG key:
RUN /usr/bin/sudo apt-get update
RUN /usr/bin/sudo apt-get install ca-certificates curl gnupg
RUN /usr/bin/sudo install -m 0755 -d /etc/apt/keyrings
RUN /usr/bin/curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN /usr/bin/sudo chmod a+r /etc/apt/keyrings/docker.gpg

# allows resolving of .localhost names
RUN /usr/bin/sudo apt-get update
RUN /usr/bin/sudo apt-get install libnss-myhostname
# Add the repository to Apt sources:
# RUN echo \
#     "deb [arch="$(/usr/bin/dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
#     "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
#     /usr/bin/sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# RUN /usr/bin/sudo apt-get update
# RUN /usr/bin/yes | /usr/bin/sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# install docker, but this doesn't work - the service doesn't start
#RUN /usr/bin/curl -fsSL https://get.docker.com -o get-docker.sh
#RUN /usr/bin/sudo sh ./get-docker.sh 

#allow docker to access non SSL registries
#RUN /usr/bin/sudo mkdir /etc/docker/
#RUN /usr/bin/docker stop $(/usr/bin/docker ps -a -q)
#unmount docker volume because we don't want to do that
#RUN /usr/bin/sudo umount /var/lib/docker
#RUN echo '{ "insecure-registries":["192.1.0.0/8"] }' | /usr/bin/sudo tee /etc/docker/daemon.json

# install some zenml integrations
#RUN zenml integration install kubernetes


