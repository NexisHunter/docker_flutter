# Grab the base OS to be used to run the Flutter for Desktop
FROM google/dart as base

USER root
# Install the dependencies needed to run Flutter with desktop embedding.
RUN apt-get -qq update
RUN apt-get -qq install -y unzip xz-utils build-essential clang make
RUN apt-get install -y cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev \
    libblkid-dev \
    liblzma-dev
    
# Ensure Google chrome is available.
# Followed https://linuxize.com/post/how-to-install-google-chrome-web-browser-on-debian-10/ for link.
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt install -y ./google-chrome-stable_current_amd64.deb

# Use the base image with all of the prerequisites installed
FROM base as base-edit

WORKDIR /usr/local/
# Clone the Flutter sdk.
RUN git clone "https://github.com/flutter/flutter.git"

# Export adjusted PATH
ENV PATH=$PATH:"/usr/local/flutter/bin"

# Configure Flutter
RUN flutter config --enable-linux-desktop
RUN flutter config --enable-web
RUN flutter precache linux web

WORKDIR /workspace
ENV CHROME_EXECUTABLE=google-chrome-stable
