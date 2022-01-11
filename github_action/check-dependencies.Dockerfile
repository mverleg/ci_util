
FROM mverleg/rust_nightly_musl_base:nodeps_2022-01-01_24

# Copy the code (all except .dockerignore).
COPY ./ ./

# Build dev with all features.
RUN touch -c build.rs src/main.rs src/lib.rs &&\
    cargo build --all-features --tests

# Check dependencies
RUN cargo --offline audit --deny warnings
RUN cargo --offline deny check advisories
RUN cargo --offline deny check licenses
RUN cargo --offline deny check bans
#RUN cargo udeps --all-targets --all-features
#TODO @mark: more checks here?
