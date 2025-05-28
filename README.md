# Docker

This repository manages Dockerfiles for various environments, providing reproducible and portable setups for different applications.

## Available Environments

These are designed to provide a ready-to-use development environment for data science and statistical computing.

### `ubuntu20_04/`

A Docker environment based on **Ubuntu 20.04** with **Python 3.10** and **R** installed.

### `ubuntu22_04/`

A Docker environment based on **Ubuntu 22.04** with **Python 3.11** and **R** installed.

### `ubuntu22_04_tex/`

A Docker environment based on **Ubuntu 22.04** with **Python 3.11**, **R**, and a **TeX** installed.

### Key Components (shared across environments)

- **`r_setup.R`**  
  Installs essential R packages.

- **`requirements.txt`**  
  Lists Python libraries to be installed using `pip`.

- **`settings.json`**  
  VS Code settings for seamless development inside the container when connected via Remote - Containers.

### Features

- Ubuntu base image
- R and essential R packages
- Essential Python libraries
- Ready-to-use Docker Compose templates (CPU/GPU)
- VS Code integration support

# Basic Docker Commands and Examples

## Docker Login & Logout

```bash
# Check current logged-in user
docker info  # Look for "Username" below "Dehub Mode"

# Login to Docker Hub
docker login docker.io
# Enter your Docker ID and password

# Logout
docker logout
```

## Common Docker Commands

```bash
# List all containers (including stopped ones)
docker ps -a

# Stop a container
docker stop <container_name_or_id>

# Remove a container
docker rm <container_name_or_id>

# List all images
docker images

# Remove an image
docker rmi <image_id_or_name>

# Tag an image
docker tag <source_image> <target_image>

# Push an image to Docker Hub
docker push <image_name>

# Pull an image from Docker Hub
docker pull <image_name>

# Create an image from a container
docker commit <container_id> <new_image_name>

# Build an image from a Dockerfile
docker build -t <image_name> <path_to_dockerfile>

# Build and push a multi-platform image
docker buildx build -t <image_name> <path_to_dockerfile>
```

### Example Commands

```bash
# Commit a running container as a new image
docker commit 170a35e71836 docker.io/downey21/repo_private:r_v1
```

```bash
# Build a local image from the Dockerfile
docker build -t docker.io/downey21/repo_private: .
```

```bash
# Build and push a multi-architecture image
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t docker.io/downey21/repo_private:r \
  --push \
  .
```

## Running Docker Containers

There are multiple ways to run or interact with Docker containers depending on your use case. Below are three commonly used commands and their differences.

### 1. `docker exec -it <container_name_or_id> /bin/bash`

- Attach to a **running** container and start a bash session.
- The container must already be running.
- Useful for debugging or inspecting the running environment.

### 2. `docker run -it --rm <image_name> bash`

- Create and run a **new container** from an image and launch bash.
- `--rm` automatically removes the container after it exits.
- Ideal for temporary or one-time tasks (e.g., debugging, quick tests).

### 3. `docker run -dit <image_name>`

- Create and run a **new container in the background** (detached mode).
- The container continues running even after the terminal is closed.
- Commonly used for running services or applications (e.g., servers, notebooks).

### 4. Run a Docker Container via SLURM on a Specific Node

```bash
srun --nodelist=node01 --pty docker run -it --rm <image_name> bash
```

- Schedules an interactive job on `node01` using SLURM and launches a Docker container.
- Used in HPC or cluster environments with job schedulers like SLURM.
- Combines containerization with resource management across compute nodes.

### Example Commands

```bash
# Run a container in detached interactive mode
docker run -dit \
  --name r_dev \
  --volume /home/dhseo/Project:/root/Project \
  --volume /home/dhseo/settings.json:/root/.vscode/settings.json \
  docker.io/downey21/repo_private:r
```

```bash
# Run a container interactively and mount volumes
docker run -it --rm \
    -v /node05_storage:/root/data \
    -v /home/dhseo/Project:/root/Project \
    docker.io/downey21/r bash
```

```bash
# Same as above, but run the container on node01 via SLURM
srun --nodelist=node01 --pty docker run -it --rm \
    -v /node05_storage:/root/data \
    -v /home/dhseo/Project:/root/Project \
    docker.io/downey21/r bash
```

### Notes
- `docker.io/` is the default registry for Docker Hub.
- Replace placeholders like `<...>` with your actual values.
