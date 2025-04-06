# Docker

This repository manages Dockerfiles for various environments, providing reproducible and portable setups for different applications.

## Available Environments

### `ubuntu20_04/`

A Docker environment based on **Ubuntu 20.04** with **Python 3.10** and **R** installed.

This setup is designed to provide a ready-to-use development environment for data science and statistical computing.

### Key Components

- **`r_setup.R`**  
  Installs essential R packages.

- **`requirements.txt`**  
  Lists Python libraries to be installed using `pip`.

- **`compose_name.yml`**  
  A template Docker Compose file for easy container setup.

- **`compose_name_gpu.yml`**  
  A GPU-enabled version of `compose_name.yml` for environments requiring GPU support.

- **`settings.json`**  
  VS Code settings for seamless development inside the container when connected via Remote - Containers.

### Features

- Ubuntu 20.04 base image
- Python 3.10
- R and essential R packages
- Essential Python libraries
- Ready-to-use Docker Compose templates (CPU/GPU)
- VS Code integration support
