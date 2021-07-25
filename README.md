# Mark's CI Utils

## Rust nightly musl base Docker image

Docker: https://hub.docker.com/repository/docker/mverleg/rust_nightly_musl_base

Includes utilities like clippy, fmt, dependency utils and web-pack.

Can pre-build dependencies in a separate Docker layer for performance::

    COPY ./Cargo.toml ./Cargo.toml
    RUN sh build_dependencies_only.sh  # debug
    RUN sh build_dependencies_only.sh --release

You have to be careful to pass the same cargo flags in subsequent builds.

## Selenium driver

Docker: https://hub.docker.com/repository/docker/mverleg/selenium_driver

Derived from https://github.com/dimmg/dockselpy (but with several features stripped).

This image allows running Selenium tests against Firefox or Chrome.
