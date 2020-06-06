## based on ubuntu 18.04 with ros ${ROSDISTRO}
FROM osrf/ros:melodic-desktop-full

LABEL maintainer "Gal Brandwine <gal080592@gmail.com>"
# Configurations
ARG DEVELOPER=gal
ARG ROSDISTRO=melodic
ARG PYCHARM_VERSION=2020.2
ARG PYCHARM_BUILD=202.5103.19


## nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

## Dependencies
RUN apt-get update && apt-get install --no-install-recommends -y \
  python python-dev python-setuptools python-pip \
  python3 python3-dev python3-numpy python3-setuptools python3-pip python3-tk python3-yaml \
  gcc git openssh-client less curl \
  libxtst-dev libxext-dev libxrender-dev libfreetype6-dev \
  libfontconfig1 libgtk2.0-0 libxslt1.1 libxxf86vm1 \
  gedit \
  python-catkin-tools \
  ros-${ROSDISTRO}-cv-bridge

RUN rm -rf /var/lib/apt/lists/*
RUN useradd -ms /bin/bash ${DEVELOPER}


RUN pip3 install --upgrade pip
RUN pip3 install opencv-python matplotlib rospkg catkin_pkg scipy

## AV library dependencies (For the TelloDrone)
RUN apt-get install -y libavformat-dev libavdevice-dev
RUN apt-get install -y libsm6 libxext6 libxrender-dev
RUN pip3 install av==6.1.2


## Pycharm installation
ARG pycharm_source=https://download.jetbrains.com/python/pycharm-community-${PYCHARM_BUILD}.tar.gz
ARG pycharm_local_dir=.PyCharmCE${PYCHARM_VERSION}

WORKDIR /opt/pycharm

RUN curl -fsSL $pycharm_source -o /opt/pycharm/installer.tgz \
  && tar --strip-components=1 -xzf installer.tgz \
  && rm installer.tgz

USER ${DEVELOPER}
ENV HOME /home/${DEVELOPER}

RUN mkdir /home/${DEVELOPER}/.PyCharm \
  && ln -sf /home/${DEVELOPER}/.PyCharm /home/${DEVELOPER}/$pycharm_local_dir


## copying data to docker and add settings
WORKDIR /
COPY ros_entrypoint.sh .
USER root
RUN chmod +x ros_entrypoint.sh

## Creating catkin_ws
USER root
ENV CATKIN_WS=/home/${DEVELOPER}/catkin_ws
RUN /bin/bash -c "mkdir -p $CATKIN_WS/src && cd $CATKIN_WS && source /opt/ros/melodic/setup.bash && catkin_make"

# USER ${DEVELOPER}
WORKDIR $CATKIN_WS