FROM ubuntu:22.04

# docker build -t docker.io/downey21/repo_private:r_tex .

# docker buildx build \
#   --platform linux/amd64,linux/arm64 \
#   -t docker.io/downey21/repo_private:r_tex \
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

RUN apt update -y && \
    apt install -y \
        perl \
        xz-utils \
        fontconfig \
        unzip \
        make \
        cabextract

RUN curl -L -o install-tl-unx.tar.gz https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar -xzf install-tl-unx.tar.gz && \
    cd install-tl-* && \
    perl ./install-tl --no-interaction --scheme=small --no-doc-install --no-src-install && \
    cd / && \
    rm -rf install-tl-* install-tl-unx.tar.gz

RUN ARCH=$(uname -m | sed 's/x86_64/x86_64-linux/; s/aarch64/aarch64-linux/') && \
    echo "export PATH=/usr/local/texlive/2025/bin/$ARCH:\$PATH" >> /etc/profile.d/texlive.sh

ENV PATH="/usr/local/texlive/2025/bin/$(uname -m | sed 's/x86_64/x86_64-linux/; s/aarch64/aarch64-linux/'):$PATH"

RUN ARCH=$(uname -m | sed 's/x86_64/x86_64-linux/; s/aarch64/aarch64-linux/') && \
    /usr/local/texlive/2025/bin/$ARCH/tlmgr install \
        scheme-small \
        latex-bin \
        beamer \
        biblatex \
        xcolor \
        fontspec \
        pgf \
        etoolbox \
        xetex \
        biber \
        framed \
        pgfopts \
        xkeyval \
        kotex-utf \
        unfonts-core \
        kotex-utils \
        kotex-plain \
        xetexko 

RUN mkdir -p /usr/local/share/texmf/tex/latex/metropolis && \
    git clone --depth=1 https://github.com/matze/mtheme.git /usr/local/share/texmf/tex/latex/metropolis

RUN git clone https://github.com/matze/mtheme.git /mtheme && \
    cd /mtheme/source && \
    /usr/local/texlive/2025/bin/$(uname -m | sed 's/x86_64/x86_64-linux/; s/aarch64/aarch64-linux/')/latex beamerthememetropolis.ins && \
    mkdir -p /usr/local/texlive/texmf-local/tex/latex/metropolis && \
    cp *.sty /usr/local/texlive/texmf-local/tex/latex/metropolis && \
    /usr/local/texlive/2025/bin/$(uname -m | sed 's/x86_64/x86_64-linux/; s/aarch64/aarch64-linux/')/mktexlsr && \
    rm -rf /mtheme

RUN mkdir -p /usr/share/fonts/truetype/msttcorefonts && \
    cd /usr/share/fonts/truetype/msttcorefonts && \
    curl -LO https://downloads.sourceforge.net/corefonts/arial32.exe && \
    cabextract -F '*.TTF' arial32.exe && \
    rm arial32.exe && \
    fc-cache -fv

RUN arch=$(dpkg --print-architecture) && \
    if [ "$arch" = "arm64" ]; then \
        sed -i 's|http://archive.ubuntu.com/ubuntu|http://ports.ubuntu.com/ubuntu-ports|g' /etc/apt/sources.list && \
        echo "deb http://ports.ubuntu.com/ubuntu-ports jammy universe" >> /etc/apt/sources.list; \
    else \
        echo "deb http://archive.ubuntu.com/ubuntu jammy universe" >> /etc/apt/sources.list; \
    fi && \
    apt-get update && \
    apt-get install -y fonts-nanum && \
    fc-cache -fv

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*
