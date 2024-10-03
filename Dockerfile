
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

# Setup history
RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/home/$USERNAME/.bash/history" \
    && mkdir /home/$USERNAME/.bash \
    && touch /home/$USERNAME/.bash/history \
    && chown -R $USERNAME /home/$USERNAME/.bash \
    && echo "$SNIPPET" >> "/home/$USERNAME/.bashrc"

# Installs envconsul
ADD https://releases.hashicorp.com/envconsul/0.13.2/envconsul_0.13.2_linux_amd64.zip /var/tmp/
RUN apt-get update \
    && apt-get install -y unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && unzip /var/tmp/envconsul_0.13.2_linux_amd64.zip -d /usr/bin \
    && apt-get remove -y unzip

# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME

EXPOSE 3000
EXPOSE 8080
EXPOSE 8089
