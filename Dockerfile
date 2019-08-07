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
COPY janet-1.1.0/build/janet /usr/local/bin/janet
COPY janet-1.1.0/src/include/janet.h /usr/local/include/janet
COPY janet-1.1.0/src/conf/janetconf.h /usr/local/include/janet
COPY janet-1.1.0/build/libjanet.a /usr/local/lib/libjanet.a
COPY janet-1.1.0/build/libjanet.so /usr/local/lib/libjanet.so.1.1.0-dev
COPY janet-1.1.0/build/libjanet.so /usr/local/lib/libjanet.so
COPY janet-1.1.0/build/libjanet.so /usr/local/lib/libjanet.so.1
# cook and path
COPY janet-1.1.0/auxlib /usr/local/lib/janet
# jpm
COPY janet-1.1.0/auxbin /usr/local/bin
COPY janet-1.1.0/janet.1 /usr/local/share/man/man1/
RUN ldconfig /usr/local/lib

# Application setup
WORKDIR /var/app
RUN chmod 777 /var/app
USER $USER
