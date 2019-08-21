FROM ubuntu:19.10

# Set group and user IDs for docker user
ARG GID=1000
ARG UID=1000
ARG USER=me

# Create the group and user
RUN groupadd -g $GID $USER
RUN useradd -g $GID -M -u $UID -d /var/app $USER 

# Install Janet
RUN mkdir -p /usr/local/include/janet \
    mkdir -p /usr/local/lib/janet \
    mkdir -p /usr/local/share/man/man1
COPY janet/build/janet /usr/local/bin/janet
COPY janet/src/include/janet.h /usr/local/include/janet
COPY janet/src/conf/janetconf.h /usr/local/include/janet
COPY janet/build/libjanet.a /usr/local/lib/libjanet.a
COPY janet/build/libjanet.so /usr/local/lib/libjanet.so.1.1.0-dev
COPY janet/build/libjanet.so /usr/local/lib/libjanet.so
COPY janet/build/libjanet.so /usr/local/lib/libjanet.so.1
# cook and path
COPY janet/auxlib /usr/local/lib/janet
# jpm
COPY janet/auxbin /usr/local/bin
COPY janet/janet.1 /usr/local/share/man/man1/
RUN ldconfig /usr/local/lib

# Application setup
WORKDIR /var/app
RUN chmod 777 /var/app
USER $USER
