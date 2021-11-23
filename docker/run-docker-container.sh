#!/usr/bin/env bash

# Get script path
file_dir=$(dirname $0)

# Start sharing xhost
xhost +local:root

docker run --rm \
  --net=host \
  --ipc=host \
  --gpus all \
  --privileged \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v $HOME/.Xauthority:$docker/.Xauthority \
  -v $HOME/autorace:$HOME/autorace \
  -e XAUTHORITY=$home_folder/.Xauthority \
  -e DISPLAY=$DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -it --name "ros-noetic" ${user}/ros-focal-noetic