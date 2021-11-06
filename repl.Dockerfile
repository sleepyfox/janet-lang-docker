FROM docker.io/alpine:3.11 as build
ARG JANET=1.18.1
ARG USER=app
ARG GROUP=app
ARG GID=1000
ARG UID=1000
WORKDIR /tmp/janet
RUN apk add --no-cache build-base curl git bash && \
addgroup -g $GID -S $GROUP && \
adduser -u $UID -S $USER -G $GROUP && \
git clone -q --depth 1 --branch v$JANET https://github.com/janet-lang/janet.git . && \
make all test install && \
chmod 777 /usr/local/lib/janet
WORKDIR /tmp/jpm
RUN git clone --depth=1 https://github.com/janet-lang/jpm.git . && \
janet bootstrap.janet && \
janet -v && jpm -h && \
mkdir -p /var/app && \
chown -R $USER:$GROUP /var/app
WORKDIR /var/app
COPY ./project.janet .
RUN jpm deps &&  chown -R $USER:$GROUP /usr/local/lib/janet/joy
COPY ./src src
COPY ./test test
USER $USER
CMD ["janet"]
