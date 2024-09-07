FROM ubuntu:noble AS base

RUN mv /etc/apt/apt.conf.d/docker-clean /opt/docker-clean && \
  echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  apt update && \
  apt-get install -y build-essential curl ca-certificates pkg-config libtool-bin libdb-dev universal-ctags yacc bison libssl-dev libpcre3-dev libutempter-dev libutf8proc-dev
RUN mv /opt/docker-clean /etc/apt/apt.conf.d/docker-clean && \
  rm /etc/apt/apt.conf.d/keep-cache

FROM base AS final
WORKDIR /opt
RUN mkdir -p prefix base archive output
VOLUME [ "/opt/archive" ]

ENV ARCHIVE_BASE=/opt/archive
ENV BUILD_BASE=/opt/base
ENV PREFIX=/opt/prefix
ENV OUTPUT_DIR=/opt/output

COPY scripts /opt/scripts

CMD [ "/opt/scripts/build.sh" ]
