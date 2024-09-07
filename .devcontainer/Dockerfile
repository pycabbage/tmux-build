FROM mcr.microsoft.com/devcontainers/base:noble

RUN mv /etc/apt/apt.conf.d/docker-clean /opt/docker-clean && \
  echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  sed -i.bak -E 's/^(read -p)/REPLY=y #\1/; s/(apt-get upgrade)$/\1 -y/' $(which unminimize) && \
  unminimize && \
  apt update && \
  apt-get --no-install-recommends install -y build-essential fuse
RUN mv /opt/docker-clean /etc/apt/apt.conf.d/docker-clean && \
  rm /etc/apt/apt.conf.d/keep-cache
