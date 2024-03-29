
#TODO @mark: switch back to deps version
FROM mverleg/rust_nightly_musl_base:nodeps_2024-02-17_42

# Copy the code (all except .dockerignore).
COPY ./ ./

# Build (for test)
ARG TEST=1
RUN echo "TEST=$TEST" &&\
    find . -name target -prune -o -type f &&\
    touch -c build.rs src/main.rs src/lib.rs &&\
    # make sure Cargo.lock is added to git, or --locked will fail \
    if [ "$TEST" != 0 ] ; then \
        cargo build --all-features --tests --locked; \
    else \
        cargo build --all-features --locked; \
    fi

# Test
RUN if [ "$TEST" != 0 ] ; then  \
        cargo --offline test --all-features;  \
    else  \
        echo SKIPPED;  \
    fi

## Examples
#ARG EXAMPLES=1
#RUN echo "EXAMPLES=$EXAMPLES" &&\
#    if [ "$EXAMPLES" != 0 ] ; then  \
#        cargo --offline test --all-features;  \
#    else  \
#        echo SKIPPED;  \
#    fi

# Lint
ARG LINT=1
ARG STRICT=1
RUN echo "LINT=$LINT STRICT=$STRICT" &&\
    if [ "$LINT" != 0 ] ; then  \
        if [ "$STRICT" != 0 ] ; then  \
            cargo --offline clippy --all-features --tests -- -D warnings;  \
        else  \
            cargo --offline clippy --all-features --tests;  \
        fi \
    else  \
        echo SKIPPED;  \
    fi

# Style
ARG FMT=1
RUN echo "FMT=$FMT" &&\
    if [ "$FMT" != 0 ] ; then  \
        cargo --offline fmt --all -- --check;  \
    else  \
        echo SKIPPED;  \
    fi

