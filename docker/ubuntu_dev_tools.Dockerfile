
FROM ubuntu:20.04

# todo maybe get rid of --allow-insecure-repositories somehow
RUN apt-get update --allow-insecure-repositories && apt-get dist-upgrade --allow-unauthenticated -y
RUN apt-get install --allow-unauthenticated -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common linux-tools-common linux-tools-generic build-essential libssl-dev libffi-dev tree
RUN apt-get install --allow-unauthenticated -y git vim rsync curl sqlite3 libsqlite3-dev moreutils jq ripgrep
RUN apt-get install --allow-unauthenticated -y python3-dev python3-pip gcc default-jre default-jdk gradle
RUN pip3 install numpy scipy matplotlib seaborn scikit-learn
RUN curl https://sh.rustup.rs -sSf > /tmp/rust_install.sh && \
    bash /tmp/rust_install.sh --no-modify-path -y &&\
    rustup toolchain install nightly &&\
    rustup default nightly &&\
    sudo chown $USER:$USER -R "/home/$USER/.cache"

