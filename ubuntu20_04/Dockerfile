FROM ubuntu:20.04

# Set environment variables to non-interactive (this prevents some prompts)
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && \
    apt install -y \
        software-properties-common \
        apt-transport-https \
		wget \
        xauth \
        libgl1-mesa-glx \
        libxcb-xinerama0 \
        qt5-default \
        dirmngr \
        ca-certificates \
        build-essential \
        libcurl4-gnutls-dev \
        libxml2-dev \
        libssl-dev \
        libfontconfig1-dev \
        git

RUN apt update -qq && \
		wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc && \
		add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/"

RUN apt update -y && \
    apt install -y r-base && \
    add-apt-repository ppa:c2d4u.team/c2d4u4.0+

RUN apt update -y && \
    apt install -y \
        r-base-dev

RUN add-apt-repository ppa:deadsnakes/ppa -y && \
    apt update -y && \
    apt install -y python3.10 python3.10-distutils python3-dev gcc

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    rm get-pip.py && \
    python3 -m pip install --upgrade pip

COPY ./requirements.txt /requirements.txt
COPY ./r_setup.R /r_setup.R

RUN pip install -r /requirements.txt && \
    Rscript /r_setup.R

RUN apt update -y && \
    apt install -y locales && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt update -y && \
    apt install -y \
        libharfbuzz-dev \
        libfribidi-dev \
        libfreetype6-dev \
        libpng-dev \
        libtiff5-dev \
        libjpeg-dev \
        pandoc

# Clean up after installation to reduce image size
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*