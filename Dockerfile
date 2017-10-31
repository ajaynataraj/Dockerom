FROM ubuntu:16.04
MAINTAINER Michael Stucki <michael@stucki.io>


ENV \
# ccache specifics
    CCACHE_SIZE=50G \
    CCACHE_DIR=/srv/ccache \
    USE_CCACHE=1 \
    CCACHE_COMPRESS=1 \
# Extra include PATH, it may not include /usr/local/(s)bin on some systems
    PATH=$PATH:/usr/local/bin/



RUN sed -i 's/main$/main universe/' /etc/apt/sources.list \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y \
# Install build dependencies (source: https://wiki.cyanogenmod.org/w/Build_for_bullhead)
      bison \
      build-essential \
      curl \
      flex \
      git \
      gnupg \
      gperf \
      libesd0-dev \
      liblz4-tool \
      libncurses5-dev \
      libsdl1.2-dev \
      libwxgtk3.0-dev \
      libxml2 \
      libxml2-utils \
      lzop \
      maven \
      openjdk-8-jdk \
      pngcrush \
      schedtool \
      squashfs-tools \
      xsltproc \
      zip \
      zlib1g-dev \
# For 64-bit systems
      g++-multilib \
      gcc-multilib \
      lib32ncurses5-dev \
      lib32readline6-dev \
      lib32z1-dev \
# Install additional packages which are useful for building Android
      android-tools-adb \
      android-tools-fastboot \
      bash-completion \
      bc \
      bsdmainutils \
      ccache \
      file \
      imagemagick \
      nano \
      rsync \
      screen \
      sudo \
      tig \
      vim \
      wget \
 && rm -rf /var/lib/apt/lists/*
ENV \
# ccache specifics
    CCACHE_SIZE=50G \
    CCACHE_DIR=/srv/ccache \
    USE_CCACHE=1 \
    CCACHE_COMPRESS=1 \
# Extra include PATH, it may not include /usr/local/(s)bin on some systems
PATH=$PATH:/usr/local/bin/

RUN mkdir ~/bin \
 && PATH=~/bin:$PATH \
 && curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo \
 && chmod a+x ~/bin/repo \
 && mkdir ~/RR \
 && cd ~/RR \
 && repo init -u https://github.com/ResurrectionRemix/platform_manifest.git -b nougat \
 && repo sync -f --force-sync --no-clone-bundle
