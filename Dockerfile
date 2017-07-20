# This is golang
# VERSION 1
# Author: Ekanant

FROM golang

MAINTAINER wendyeq wendyeq@gmail.com

ENV LD_LIBRARY_PATH /usr/lib:/usr/local/lib:/usr/lib/oracle/12.1/client64/lib
ENV NLS_LANG AMERICAN_AMERICA.AL32UTF8

# install require software
RUN apt-get update && apt-get install -y --no-install-recommends build-essential unzip nano pkg-config libaio1

COPY instantclient-basic-linux.x64-12.1.0.2.0.zip /tmp/
COPY instantclient-sdk-linux.x64-12.1.0.2.0.zip /tmp/
COPY oci8.pc /usr/lib/pkgconfig/
RUN mkdir -p /usr/lib/oracle/12.1/client64/lib && mkdir -p /usr/include/oracle/12.1/client64/

RUN cd /tmp && unzip instantclient-basic-linux.x64-12.1.0.2.0.zip && cp /tmp/instantclient_12_1/* /usr/lib/oracle/12.1/client64/lib/
RUN cd /tmp && unzip instantclient-sdk-linux.x64-12.1.0.2.0.zip && cp /tmp/instantclient_12_1/sdk/include/* /usr/include/oracle/12.1/client64/ 

RUN ln -s /usr/lib/oracle/12.1/client64/lib/libclntsh.so.12.1 /usr/lib/oracle/12.1/client64/lib/libclntsh.so
RUN ln -s /usr/lib/oracle/12.1/client64/lib/libocci.so.12.1 /usr/lib/oracle/12.1/client64/lib/libocci.so

RUN cd /usr/lib/pkgconfig/ && curl -o oci8.pc https://raw.githubusercontent.com/wendyeq/go-oci8/master/oci8.pc  

RUN go get github.com/mattn/go-oci8

RUN rm -rf /tmp/*

