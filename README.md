# OpenPose Docker Setup - CPU Only

This repository contains a Docker setup for running OpenPose with CPU-only support. The Dockerfile installs all necessary dependencies, builds OpenPose, and sets up the environment for easy usage.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)

## Getting Started

#### 1. Clone the Repository

```sh
git clone git@github.com:MargaridaEstrela/openpose-cpu.git
cd openpose-cpu
```

### 2. Download the Models

Download the OpenPose models from the following Google Drive link:

[Google Drive Models Folder](https://drive.google.com/drive/folders/1ZrtLJBTt8lUmrSqDQuWoBWjdi96OiUJU?usp=sharing)

After downloading, place the models in the `models` directory inside the cloned repository. The directory structure should be as follows:

```scss
openpose-cpu/
├── README.md
├── Dockerfile
├── models/
│   ├── cameraParameters/
│   │   └── flir/
│   │       └── 17012332.xml.example
│   ├── face/
│   │   ├── haarcascade_frontalface_alt.xml
│   │   ├── pose_deploy.prototxt
│   │   └── pose_iter_116000.caffemodel
│   ├── getModels.bat
│   ├── getModels.sh
│   ├── hand/
│   │   ├── pose_deploy.prototxt
│   │   └── pose_iter_102000.caffemodel
│   └── pose/
│       ├── body_25/
│       │   ├── pose_deploy.prototxt
│       │   └── pose_iter_584000.caffemodel
│       ├── coco/
│       │   ├── pose_deploy_linevec.prototxt
│       │   └── pose_iter_440000.caffemodel
│       └── mpi/
│           ├── pose_deploy_linevec.prototxt
│           ├── pose_deploy_linevec_faster_4_stages.prototxt
│           └── pose_iter_160000.caffemodel
```

#### 2. Build the Docker Image
Build the Docker image using the following command:
```sh
docker build -t openpose-cpu .
```

#### 3. Run the Docker Container
To run the Docker container with OpenPose, use the following command:
```sh
docker run -it openpose-cpu
```

You can also configure the container to use specific directories on your host machine for input videos and output results. This is done by adding volume bindings with the -v flag:

```sh
docker run -it -v <path_to_input_videos_folder>:/videos -v <path_to_output_folder>:/output openpose-cpu
```

- Replace `<path_to_input_videos_folder>` with the absolute path to your local directory containing input videos.
- Replace `<path_to_output_folder>` with the absolute path to your local directory where you want to save the output images and videos.

#### 4. Run OpenPose
Once inside the container, execute OpenPose with the appropriate command:
```sh
./build/examples/openpose/openpose.bin --model_folder models/ --video /videos/your_video_file.mp4 --write_images /output/images/ --write_video /output/processed_video.avi --display 0
```
Make sure to replace your_video_file.mp4 with the actual name of your video file.

This configuration allows you to process videos stored on your local machine and save the results back to your local machine, making it easy to manage input and output data without modifying the Docker image.

## Dockerfile Details
The Dockerfile performs the following tasks:

- Uses Ubuntu 20.04 as the base image.
- Sets environment variables for non-interactive installation.
- Installs necessary dependencies and Python packages.
- Clones the OpenPose repository and sets the working directory.
- Copies the pre-downloaded models into the Docker image.
- Builds OpenPose with CPU-only support.
- Sets environment variables for OpenPose.
- Tests the OpenPose installation.

