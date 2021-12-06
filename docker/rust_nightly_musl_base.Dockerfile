
FROM clux/muslrust:nightly AS build

ENV RUST_BACKTRACE=1

RUN rustup component add rust-src
RUN rustup component add rustc-dev
RUN rustup component add llvm-tools-preview
RUN rustup component add rustfmt
RUN rustup component add clippy
RUN cargo install cargo-outdated
RUN cargo install cargo-audit
RUN cargo install cargo-deny
RUN cargo install cargo-tree
RUN cargo install cargo-edit
RUN rustup component add rustc-dev
#RUN cargo install semverver
#TODO @mark: remove --version once 0.10+ works on musl
RUN cargo install wasm-pack --version 0.9.1 --no-default-features

COPY ./util/Cargo_dependencies.toml Cargo.toml

RUN mkdir src/ && touch src/lib.rs && cargo build

RUN rm Cargo.toml src/lib.rs

COPY ./util/build_dependencies_only.sh ./build_dependencies_only.sh

