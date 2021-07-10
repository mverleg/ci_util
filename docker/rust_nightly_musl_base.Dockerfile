
FROM clux/muslrust:nightly AS build

ENV RUST_BACKTRACE=1

RUN rustup component add rustfmt
RUN rustup component add clippy
RUN cargo install cargo-outdated
RUN cargo install cargo-audit
RUN cargo install cargo-deny
RUN cargo install cargo-tree
RUN cargo install cargo-edit
#TODO @mark: remove --version once 0.10+ works on musl
RUN cargo install wasm-pack --version 0.9.1 --no-default-features

COPY ./LICENSE.txt ./LICENSE.txt

