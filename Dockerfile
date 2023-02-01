FROM ubuntu:20.04

RUN sudo apt-get update

RUN yum install systemctl

RUN apt-get update && \
    apt-get install -y docker.io

RUN apk add --update --no-cache curl \
 && curl -LO https://dl.k8s.io/release/stable.txt \
 && export version=$(cat stable.txt) \
 && curl -LO https://dl.k8s.io/$version/bin/linux/amd64/kubectl \
 && chmod +x kubectl \
 && mv kubectl /usr/local/bin/
