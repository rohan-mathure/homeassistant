# Use a docker image with python 3.10 and python3-dev paclage
FROM docker.io/python:3.12.0b4-bullseye

# Update the packages
RUN apt-get update && apt-get upgrade -y

# Install dependencies
RUN apt-get install -y sudo python3 python3-dev python3-venv python3-pip bluez libffi-dev libssl-dev libjpeg-dev zlib1g-dev autoconf build-essential libopenjp2-7 libtiff5 libturbojpeg0-dev tzdata ffmpeg liblapack3 liblapack-dev libatlas-base-dev


RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN source "$HOME/.cargo/env"
# Add Home Assistant user
ARG USERNAME=homeassistant
RUN useradd -rm ${USERNAME}

# Create directory for homeassistant installation
RUN mkdir /srv/homeassistant
RUN chown homeassistant:homeassistant /srv/homeassistant

# Create an Virtual environment for Home Assistant Core
RUN cd /srv/homeassistant
# ENTRYPOINT [ "/bin/sh" ]
RUN sudo -u ${USERNAME} -H -s && cd /srv/homeassistant && python3 -m venv .
RUN cd /srv/homeassistant && . bin/activate && python3 -m pip install wheel && pip3 install homeassistant==2023.7.3
ENTRYPOINT [ "hass" ]
