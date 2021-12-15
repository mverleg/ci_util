
FROM mverleg/pastacode-base:latest

# Copy the actual code.
COPY ./Cargo.toml ./Cargo.lock ./build.rs ./deny.toml ./
COPY ./src ./src
COPY ./examples ./examples
COPY ./grammar ./grammar

# Upgrade dependencies
RUN cargo upgrade &&\
    cargo update

# Really up-to-date?
RUN cargo --offline outdated --exit-code 1
