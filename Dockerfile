FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04
ARG DEBIAN_FRONTEND=noninteractive

# UTF-8 included in nvidia's image but not activated. Needed for a lot of things.
ENV LANG="C.UTF-8" LC_ALL="C.UTF-8"

RUN echo 'Etc/UTC' > /etc/timezone \
    && ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime


RUN apt-get update \
    # For ppa
    && apt-get install -y software-properties-common \ 
    curl \
    # Enable universe repositories
    && add-apt-repository universe

WORKDIR /code

# Installation of Python
RUN apt-get update
RUN apt-get install -y \
    python3.10 \
    python3-pip 

RUN apt-get install -y sudo git

RUN mkdir -p /etc/OpenCL/vendors && \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

# Create user & add to sudoers
ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG USER_SH=/bin/bash
RUN groupadd -g $USER_GID $USERNAME \
  && useradd -u $USER_UID -g $USER_GID -s $USER_SH -m $USERNAME \
  && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
  && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

CMD ["bash"]



