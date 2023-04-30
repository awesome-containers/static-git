# https://github.com/awesome-containers/static-bash
ARG STATIC_BASH_VERSION=5.2.15
ARG STATIC_BASH_IMAGE=ghcr.io/awesome-containers/static-bash

FROM $STATIC_BASH_IMAGE:$STATIC_BASH_VERSION AS static-bash
FROM docker.io/debian:bullseye AS build

# hadolint ignore=DL3008
RUN set -xeu; \
    apt-get update; \
    apt-get install --no-install-recommends -y \
        ca-certificates curl tar xz-utils \
        build-essential autoconf make gettext zlib1g-dev; \
    update-ca-certificates

# https://github.com/git/git
# https://kernel.org/pub/software/scm/git/
ARG GIT_VERSION=2.40.1

WORKDIR /src/git
# RUN git clone --depth 1 --branch "v$GIT_VERSION" https://github.com/git/git.git .
RUN set -xeu; \
    curl -#Lo git.tar.xz \
        "https://kernel.org/pub/software/scm/git/git-$GIT_VERSION.tar.xz"; \
    tar -xvf git.tar.xz --strip-components=1; \
    rm -f git.tar.xz

COPY patches/ .

ARG CFLAGS='-w -g -Os -static'
RUN set -xeu; \
    patch builtin/init-db.c < template_dir.patch; \
    make configure; \
    ./configure --bindir="$(pwd)/dist/bin/" --prefix='' \
        --with-libpcre2 --with-expat \
        --without-curl --without-python --without-tcltk --without-gettext; \
    make -j"$(nproc)" install; \
    strip -s -R .comment --strip-unneeded dist/bin/git; \
    chmod -cR 755 dist/bin/git; \
    chown -cR 0:0 dist/bin/git; \
    ! ldd dist/bin/git && :; \
    ./dist/bin/git --version

# static git image
FROM static-bash
COPY --from=build /src/git/dist/bin/git /bin/git
