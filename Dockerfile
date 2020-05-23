# Grab the base OS to be used to run the Flutter for Desktop
FROM google/dart as base

USER root
# Install the dependencies needed to run Flutter with desktop embedding.
RUN apt-get -qq update
RUN apt-get -qq install -y unzip xz-utils build-essential clang make

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
