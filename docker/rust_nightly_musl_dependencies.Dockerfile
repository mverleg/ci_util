
ARG BASE_VERSION
FROM mverleg/rust_nightly_musl_base:${BASE_VERSION} AS build

COPY ./util/Cargo.toml Cargo.toml
COPY ./util/dependencies.txt dependencies.txt
RUN cat dependencies.txt >> Cargo.toml

RUN mkdir src/ && touch src/lib.rs && cargo build

RUN rm Cargo.toml dependencies.txt src/lib.rs
