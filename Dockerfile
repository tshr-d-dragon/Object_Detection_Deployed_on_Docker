FROM tensorflow/tensorflow:latest-gpu-jupyter

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y git \
                                        gpg-agent \
                                        python3-cairocffi \
                                        protobuf-compiler \
                                        python3-pil \
                                        python3-lxml \
                                        python3-tk \
                                        wget \
                                        ffmpeg \
                                        libsm6 \
                                        libxext6  

# Add new user to avoid running as root
RUN useradd -ms /bin/bash tensorflow
USER tensorflow
WORKDIR /home/tensorflow

# Copy this version of of the model garden into the image
COPY --chown=tensorflow . /home/tensorflow/models

# Compile protobuf configs
RUN (cd /home/tensorflow/models/research/ && protoc object_detection/protos/*.proto --python_out=.)
WORKDIR /home/tensorflow/models/research/

RUN cp object_detection/packages/tf2/setup.py ./
ENV PATH="/usr/lib/:${PATH}" 
ENV PATH="/home/tensorflow/.local/bin:${PATH}" 
ENV PYTHONPATH="/home/tensorflow/models/research" 
ENV PYTHONPATH="${PYTHONPATH}:/home/tensorflow/models/research/object_detection" 
ENV PYTHONPATH="${PYTHONPATH}:/home/tensorflow/models/research/object_detection/utils" 
ENV PYTHONPATH="${PYTHONPATH}:/home/tensorflow/models/research/object_detection/legacy" 
ENV PYTHONPATH="${PYTHONPATH}:/home/tensorflow/models/research/object_detection/protos" 
ENV PYTHONPATH="${PYTHONPATH}:/home/tensorflow/models/research/slim"

RUN python -m pip install -U pip
RUN python -m pip install .

ENV TF_CPP_MIN_LOG_LEVEL 3

WORKDIR /home/work/