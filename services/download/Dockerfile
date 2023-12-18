FROM bash:alpine3.15

RUN apk add parallel aria2 git git-lfs
COPY . /docker
RUN chmod +x /docker/download.sh && bash /docker/download.sh 

ENTRYPOINT ["/docker/download.sh"]
