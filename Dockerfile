FROM alpine:3.12
RUN apk add --update --no-cache curl \
 && curl -LO https://dl.k8s.io/release/stable.txt \
 && export version=$(cat stable.txt) \
 && curl -LO https://dl.k8s.io/$version/bin/linux/amd64/kubectl \
 && chmod +x kubectl \
 && mv kubectl /usr/local/bin/

RUN 
CMD [ "kubectl" ]
