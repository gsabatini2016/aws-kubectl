FROM debian:stable-slim
#
# ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
# ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
# ENV AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}

ARG LIBJQ1_REPOSITORY
ARG JQ_REPOSITORY
ARG AWS_CLI_REPOSITORY
ARG LIBONIG5_REPOSITORY

RUN mv bin/unzip /usr/bin/
RUN mv bin/kubectl /usr/bin/
RUN mv bin/less /usr/bin

WORKDIR /tmp/
ADD ${LIBJQ1_REPOSITORY} libjq1.deb
ADD ${JQ_REPOSITORY} jq.deb
ADD ${AWS_CLI_REPOSITORY} aws.zip
ADD ${LIBONIG5_REPOSITORY} libonig5.deb

RUN chmod +x libjq1.deb
RUN chmod +x jq.deb
RUN chmod +x libonig5.deb


RUN dpkg -i libonig5.deb libjq1.deb jq_1.6-2.1_amd64.deb

RUN chmod +x /usr/bin/unzip
RUN chmod +x /usr/bin/less
RUN chmod +x /usr/bin/kubectl


RUN unzip aws.zip
RUN ./aws/install
RUN rm -r /tmp/* /usr/bin/unzip
