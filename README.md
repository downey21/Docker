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
