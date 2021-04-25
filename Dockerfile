FROM debian:unstable-slim

ENV AWS_ACCESS_KEY=${AWS_ACCESS_KEY}
ENV AWS_SECRET_KEY=${AWS_SECRET_KEY}

RUN apt update && apt install -y docker.io git zip
ADD https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip /tmp/aws.zip
RUN cd /tmp/ && unzip aws
RUN ./tmp/aws/install
RUN rm -r /tmp/*
RUN apt purge -y zip
