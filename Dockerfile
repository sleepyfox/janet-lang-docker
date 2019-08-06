FROM ubuntu:19.10

# Install Janet
RUN apt -q update && apt install -yq curl
COPY janet-lang/build/janet /var/app/janet
RUN chmod +x /var/app/janet

# Set group and user IDs for docker user
ARG GID=1000
ARG UID=1000
ARG USER=me

# Create the group and user
RUN groupadd -g $GID $USER
RUN useradd -g $GID -M -u $UID -d /var/app $USER 

WORKDIR /var/app
RUN chmod 777 /var/app
USER $USER
