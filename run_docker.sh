#!/bin/bash
xhost +
docker run -it \
-v ~/docker/shared:/root/work/shared \
-e DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
--privileged \
--net=host \
--env="QT_X11_NO_MITSHM=1" \
--gpus=all \
--runtime=nvidia \
--name=tello_ros_docker \
ros_ubuntu_18 \
bash
