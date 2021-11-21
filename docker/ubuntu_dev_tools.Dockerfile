
FROM ubuntu:20.04

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
RUN apt-get install --allow-unauthenticated -y curl
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

RUN pip3 install numpy
RUN pip3 install scipy
RUN pip3 install matplotlib
RUN pip3 install seaborn
RUN pip3 install scikit-learn

RUN curl https://sh.rustup.rs -sSf > /tmp/rust_install.sh
RUN bash /tmp/rust_install.sh --no-modify-path -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup toolchain install nightly
RUN rustup default nightly
RUN chown $USER:$USER -R "/$HOME/.cache"

#RUN printf 'devtools' > /etc/hostname &&\
#    printf '127.0.0.1    devtools' > /etc/hosts

RUN mkdir /cache &&\
    printf 'HISTFILE="/cache/.bash_history"' >> /root/.bashrc

WORKDIR /app

