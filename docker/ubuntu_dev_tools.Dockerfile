
FROM mverleg/scripts_n_utils:latest AS scripts

FROM ubuntu:24.04

# todo maybe get rid of --allow-insecure-repositories somehow
RUN apt-get update --allow-insecure-repositories && apt-get dist-upgrade --allow-unauthenticated -y
RUN apt-get install --allow-unauthenticated -y \
        apt-transport-https\
        ca-certificates\
        curl\
        gnupg-agent\
        software-properties-common\
        linux-tools-common\
        linux-tools-generic\
        build-essential\
        libssl-dev\
        libffi-dev\
        tree\
        git\
        vim\
        rsync\
        sqlite3\
        libsqlite3-dev\
        moreutils\
        jq\
        ripgrep\
        python3-dev\
        python3-pip\
        gcc\
        default-jre\
        default-jdk\
        gradle\
        sudo\
        cmake\
        pkg-config

#RUN groupadd -r -g 1000 dev\
#        useradd -r -u 1000 -g 1000 -m -d /home/dev -s /bin/bash dev\
#        printf 'dev ALL=(ALL) NOPASSWD:ALL\n' >> /etc/sudoers\
#        mkdir -p /cache && chown dev:dev /cache
#
#RUN chmod 777 -R /.cache/
#USER 1000

RUN apt-get install --allow-unauthenticated -y \
        python3-numpy \
        python3-scipy \
        python3-matplotlib \
        python3-seaborn \
        python3-sklearn python3-sklearn-lib

RUN sudo ln /usr/bin/python3 /usr/bin/python

RUN curl https://sh.rustup.rs -sSf > /tmp/rust_install.sh &&\
    bash /tmp/rust_install.sh --profile minimal -c rustfmt -c clippy --no-modify-path -y &&\
    rm /tmp/rust_install.sh
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup toolchain install nightly
RUN rustup default nightly
#RUN chown $USER:$USER -R "/$HOME/.cache"
ENV CARGO_TARGET_DIR=/cache/rust_target
ENV RUST_TEST_SHUFFLE=1
ENV RUST_BACKTRACE=1

RUN cargo install \
        rust-script \
        sd \
        ripgrep \
        fd-find
RUN cargo install --all-features --bins --git https://github.com/mverleg/rusht
RUN cargo install --all-features --bins --git https://github.com/mverleg/dockerfile_version_bumper

# own shell scripts through other util docker image
COPY --from=scripts /usr/local/cargo/bin/ /root/.cargo/bin
ENV PATH="/scripts:${PATH}"

RUN #curl -f -o "/tmp/scripts.zip" "https://github.com/mverleg/scripts/releases/latest/download/scripts.zip" &&\
#        unzip "/tmp/scripts.zip" -d "/scripts" &&\
#        rm -f "/tmp/scripts.zip"

RUN sudo printf 'HISTFILE="/cache/.bash_history"\n' >> /root/.bashrc &&\
    printf '"\e[A":     history-search-backward\n"\e[B":     history-search-forward\n"\eOA":     history-search-backward\n"\eOB":     history-search-forward\n' > /root/.inputrc

WORKDIR /app

