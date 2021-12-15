# Mark's CI Utils

## Rust nightly musl base Docker image

Docker: https://hub.docker.com/repository/docker/mverleg/rust_nightly_musl_base

Includes utilities like clippy, fmt, dependency utils and web-pack.

Can pre-build dependencies in a separate Docker layer for performance::

    COPY ./Cargo.toml ./Cargo.toml
    RUN sh build_dependencies_only.sh  # debug
    RUN sh build_dependencies_only.sh --release

You have to be careful to pass the same cargo flags in subsequent builds.

This image is meant to **build** a self-contained executable, not to execute it in production or be published. Instead use a multi-stage build to create a tiny image easily:

```
FROM mverleg/rust_nightly_musl_base:2021-10-17_11
# build everything here
RUN find . -wholename '*/release/*' -name 'exe-name-here' -type f -executable -print -exec cp {} /your_executable \;

FROM scratch
ENV PATH=/
ENV RUST_BACKTRACE=1
COPY --from=build /your_executable /your_executable
ENTRYPOINT ["your_executable"]
```

## Selenium driver

Docker: https://hub.docker.com/repository/docker/mverleg/selenium_driver

Derived from https://github.com/dimmg/dockselpy (but with several features stripped).

This image allows running Selenium tests against Firefox or Chrome.

## Python clean

Format and lint Python code, see [README](python/clean/README.md).

