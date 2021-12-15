
FROM clux/muslrust:nightly AS build
ARG WITH_DEPS=1
ENV RUST_BACKTRACE=1

COPY ./util/Cargo.toml Cargo.toml

RUN mkdir src/ && touch src/lib.rs && cargo build

COPY ./util/dependencies.txt dependencies.txt

RUN if [ "$WITH_DEPS" = "1" ]; then printf 'BUILDING WITH DEPENDENCIES\n'; cat dependencies.txt >> Cargo.toml; else printf 'BUILDING WITHOUT ANY DEPENDENCIES\n'; fi

RUN cargo build

RUN rm Cargo.toml src/lib.rs

COPY ./util/build_dependencies_only.sh ./build_dependencies_only.sh

