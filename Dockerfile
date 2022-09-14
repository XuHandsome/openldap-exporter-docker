FROM golang:alpine3.16
WORKDIR /opt/
ENV LC_ALL en_US.utf8
ENV EXPORTER_VERSION=v2.2.2

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add gcc g++ make libffi-dev openssl-dev libtool git

RUN go env -w GOPROXY=https://goproxy.cn,direct \
    && git clone -b $EXPORTER_VERSION https://github.com/tomcz/openldap_exporter.git \
    && cd /opt/openldap_exporter \
    && make

FROM alpine:3.16.2
WORKDIR /opt/
COPY --from=0 /opt/openldap_exporter/target/openldap_exporter .
EXPOSE 9330
ENTRYPOINT ["./openldap_exporter"]