FROM ubuntu:22.04

# docker build -t docker.io/downey21/repo_private:r .

# docker buildx build \
#   --platform linux/amd64,linux/arm64 \
#   -t docker.io/downey21/repo_private:r \
#   --push \
#   .

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && \
    apt install -y \
        software-properties-common \
        apt-transport-https \
		wget \
        xauth \
        libgl1-mesa-glx \
        libxcb-xinerama0 \
        qtbase5-dev \
        dirmngr \
        ca-certificates \
        build-essential \
        libcurl4-gnutls-dev \
        libxml2-dev \
        libssl-dev \
        libfontconfig1-dev \
        git \
        curl \
        vim \
        tmux

RUN apt update -qq && \
		wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc && \
		add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu jammy-cran40/"

RUN apt update -y && \
    apt install -y r-base && \
    add-apt-repository ppa:c2d4u.team/c2d4u4.0+

RUN apt update -y && \
    apt install -y \
        r-base-dev

RUN apt update -y && \
    apt install -y python3.11 python3.11-distutils python3.11-venv python3.11-dev gcc

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1

RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    rm get-pip.py && \
    python3 -m pip install --upgrade pip

COPY ./requirements.txt /requirements.txt
COPY ./r_setup.R /r_setup.R

RUN pip install -r /requirements.txt
RUN Rscript /r_setup.R

RUN apt update -y && \
    apt install -y locales && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN apt update -y && \
    apt install -y \
        libharfbuzz-dev \
        libfribidi-dev \
        libfreetype6-dev \
        libpng-dev \
        libtiff5-dev \
        libjpeg-dev \
        pandoc

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*
