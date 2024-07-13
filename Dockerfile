# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    git \
    libatlas-base-dev \
    libboost-all-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    libhdf5-serial-dev \
    libleveldb-dev \
    liblmdb-dev \
    libopencv-dev \
    libprotobuf-dev \
    libsnappy-dev \
    protobuf-compiler \
    python3-dev \
    python3-pip \
    wget \
    unzip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip3 install numpy opencv-python gdown

# Clone OpenPose repository
RUN git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose.git /openpose

# Set the working directory
WORKDIR /openpose

# Copy the models to the Docker container
COPY models /openpose/models

# Create the build directory
RUN mkdir build

# Build OpenPose with CPU-only support
WORKDIR /openpose/build
RUN cmake -DBUILD_PYTHON=ON -DBUILD_EXAMPLES=ON -DUSE_CUDNN=OFF -DUSE_CUDA=OFF -DGPU_MODE=CPU_ONLY -DDOWNLOAD_BODY_25=OFF -DDOWNLOAD_FACE=OFF -DDOWNLOAD_HAND=OFF .. && \
    make -j`nproc`

# Set environment variables for OpenPose
ENV OPENPOSE_ROOT /openpose
ENV PYTHONPATH $OPENPOSE_ROOT/build/python:$PYTHONPATH
ENV PATH $OPENPOSE_ROOT/build/examples/openpose:$PATH

# Test OpenPose installation
RUN python3 -c "import sys; sys.path.append('/openpose/build/python'); import openpose; print('OpenPose successfully installed!')"

WORKDIR /openpose

# Default command
CMD ["bash"]
