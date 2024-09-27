
# Base image
FROM dockerhub.camara.leg.br/dockerhub/library/debian:12

# Perl almost basic install
RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y gnupg build-essential \
    perl libanyevent-perl libclass-refresh-perl libcompiler-lexer-perl libdata-dump-perl \
    libio-aio-perl libjson-perl libmoose-perl libpadwalker-perl libscalar-list-utils-perl \
    libcoro-perl libhash-safekeys-perl libtemplate-perl libperl-languageserver-perl \
    cpanminus \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Install sudo
RUN apt-get update \
    && apt-get install -y sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Setup stack groups
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m -s /usr/bin/bash $USERNAME \
    && groupadd -g 5051 otrs \
    && usermod -aG 5051 www-data \
    && useradd -g 5051 -G 33 -u 5051 -M otrs \
    && usermod -aG otrs,www-data $USERNAME

# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME
