
FROM mverleg/rust_nightly_musl_base:nodeps_2024-02-17_42

COPY ./ ./

RUN cargo upgrade && cargo update

RUN cargo --offline outdated --exit-code 1
