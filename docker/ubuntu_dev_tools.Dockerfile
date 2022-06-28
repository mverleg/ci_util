
FROM ubuntu:22.04

# todo maybe get rid of --allow-insecure-repositories somehow
RUN apt-get update --allow-insecure-repositories && apt-get dist-upgrade --allow-unauthenticated -y
RUN apt-get install --allow-unauthenticated -y apt-transport-https
RUN apt-get install --allow-unauthenticated -y ca-certificates
RUN apt-get install --allow-unauthenticated -y curl
RUN apt-get install --allow-unauthenticated -y gnupg-agent
RUN apt-get install --allow-unauthenticated -y software-properties-common
RUN apt-get install --allow-unauthenticated -y linux-tools-common
RUN apt-get install --allow-unauthenticated -y linux-tools-generic
RUN apt-get install --allow-unauthenticated -y build-essential
RUN apt-get install --allow-unauthenticated -y libssl-dev
RUN apt-get install --allow-unauthenticated -y libffi-dev
RUN apt-get install --allow-unauthenticated -y tree
RUN apt-get install --allow-unauthenticated -y git
RUN apt-get install --allow-unauthenticated -y vim
RUN apt-get install --allow-unauthenticated -y rsync
RUN apt-get install --allow-unauthenticated -y sqlite3
RUN apt-get install --allow-unauthenticated -y libsqlite3-dev
RUN apt-get install --allow-unauthenticated -y moreutils
RUN apt-get install --allow-unauthenticated -y jq
RUN apt-get install --allow-unauthenticated -y ripgrep
RUN apt-get install --allow-unauthenticated -y python3-dev
RUN apt-get install --allow-unauthenticated -y python3-pip
RUN apt-get install --allow-unauthenticated -y gcc
RUN apt-get install --allow-unauthenticated -y default-jre
RUN apt-get install --allow-unauthenticated -y default-jdk
RUN apt-get install --allow-unauthenticated -y gradle
RUN apt-get install --allow-unauthenticated -y sudo
RUN apt-get install --allow-unauthenticated -y cmake

RUN groupadd -r -g 1000 dev
RUN useradd -r -u 1000 -g 1000 -m -d /home/dev -s /bin/bash dev
RUN printf 'dev ALL=(ALL) NOPASSWD:ALL\n' >> /etc/sudoers

#RUN chmod 777 -R /.cache/
USER 1000

RUN pip3 install --user numpy
RUN pip3 install --user scipy
RUN pip3 install --user matplotlib
RUN pip3 install --user seaborn
RUN pip3 install --user scikit-learn
RUN sudo ln /usr/bin/python3 /usr/bin/python

RUN curl https://sh.rustup.rs -sSf > /tmp/rust_install.sh &&\
    bash /tmp/rust_install.sh --no-modify-path -y &&\
    rm /tmp/rust_install.sh
ENV PATH="/home/dev/.cargo/bin:${PATH}"
RUN rustup toolchain install nightly
RUN rustup default nightly
RUN rustup component add rustfmt
RUN rustup component add clippy
#RUN chown $USER:$USER -R "/$HOME/.cache"
ENV CARGO_TARGET_DIR=/cache/rust_target
ENV RUST_TEST_SHUFFLE=1
ENV RUST_BACKTRACE=1

RUN clone https://github.com/mverleg/rusht rusht &&\
    ( cd rusht && cargo install --all-features --bin --path . --target-dir /bin ) &&\
    rm -rf rusht

RUN sudo mkdir /cache &&\
    sudo printf 'HISTFILE="/cache/.bash_history"\n' >> /home/dev/.bashrc &&\
    printf '"\e[A":     history-search-backward\n"\e[B":     history-search-forward\n"\eOA":     history-search-backward\n"\eOB":     history-search-forward\n' > /home/dev/.inputrc

WORKDIR /app

