
# syntax=docker/dockerfile:1

FROM ros:noetic-ros-base-focal
# Arguments
ARG USER=initial
ARG GROUP=initial
ARG UID=1000
ARG GID=${UID}
ARG SHELL=/bin/bash

# Replace apt urls
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

# Install packages
RUN  apt-get update  &&\
apt-get install -y ros-noetic-teleop-twist-joy ros-noetic-teleop-twist-keyboard ros-noetic-laser-proc ros-noetic-rgbd-launch ros-noetic-depthimage-to-laserscan ros-noetic-rosserial-arduino ros-noetic-rosserial-python ros-noetic-rosserial-server ros-noetic-rosserial-client ros-noetic-rosserial-msgs ros-noetic-amcl ros-noetic-map-server ros-noetic-move-base ros-noetic-urdf ros-noetic-xacro ros-noetic-compressed-image-transport ros-noetic-rqt-image-view ros-noetic-gmapping ros-noetic-navigation ros-noetic-interactive-markers &&\
apt-get install -y ros-noetic-rosserial-python ros-noetic-tf ros-noetic-dynamic-reconfigure*  ros-noetic-urdf* ros-noetic-compressed-image-transport* 

# Env vars for the nvidia-container-runtime.
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute

# Setup users and groups
RUN groupadd --gid ${GID} ${GROUP} \
  && useradd --gid ${GID} --uid ${UID} -ms ${SHELL} ${USER} \
  && mkdir -p /etc/sudoers.d \
  && echo "${USER}:x:${UID}:${UID}:${USER},,,:$HOME:${shell}" >> /etc/passwd \
  && echo "${USER}:x:${UID}:" >> /etc/group \
  && echo "${USER} ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/${USER}" \
  && chmod 0440 "/etc/sudoers.d/${USER}"

# copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh

# setup terminator config
RUN mkdir -p /home/${USER}/.config/terminator
COPY config/config /home/${USER}/.config/terminator
RUN sudo chown -R ${USER}:${GROUP} /home/${USER}/.config

# Switch user to ${USER}
USER ${USER}

# Make SSH available
EXPOSE 22

# Switch to user's HOME folder
WORKDIR /home/${USER}

# CMD ["terminator"]
# ENTRYPOINT ["/entrypoint.sh", "terminator"]