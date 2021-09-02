FROM debian:stable-slim

ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
ENV AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}

COPY bin/unzip /usr/bin/
COPY bin/kubectl /usr/bin/
COPY bin/less /usr/bin

WORKDIR /tmp/
ADD http://ftp.debian.org/debian/pool/main/j/jq/libjq1_1.6-2.1_amd64.deb libjq1.deb
ADD http://ftp.us.debian.org/debian/pool/main/j/jq/jq_1.6-2.1_amd64.deb jq_1.6-2.1_amd64.deb
ADD https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip aws.zip
ADD http://ftp.debian.org/debian/pool/main/libo/libonig/libonig5_6.9.7.1-2_amd64.deb libonig5.deb
RUN chmod +x jq_1.6-2.1_amd64.deb
RUN chmod +x libjq1.deb
RUN chmod +x libonig5.deb
RUN dpkg -i libonig5.deb
RUN dpkg -i libjq1.deb
RUN dpkg -i jq_1.6-2.1_amd64.deb
RUN chmod +x /usr/bin/unzip
RUN chmod +x /usr/bin/less
RUN chmod +x /usr/bin/kubectl
RUN unzip aws.zip
RUN ./aws/install
RUN rm -r /tmp/* /usr/bin/unzip
