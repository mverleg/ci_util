
CI Utils
===============================

* Rust nightly musl base Docker image.

    Includes utilities like clippy, fmt, dependency utils and web-pack.

    Can pre-build dependencies in a separate Docker layer for performance::

        COPY ./Cargo.toml ./Cargo.toml
        RUN sh build_dependencies_only.sh

