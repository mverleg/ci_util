#!/usr/bin/env sh

# $1: extra cargo flags

set -eEu

if [ ! -f Cargo.toml ]
then
    printf 'No Cargo.toml found\n' 1>&2
    exit 1
fi

grep -E '^(build|path)\s*=\s*"([^"]*)"' Cargo.toml |
    sed -E 's/.*"([^"]*)".*/\1/' |
    xargs -I'$' sh -xc '
        mkdir -p "$(dirname $)";
        printf "\n// generated file to build dependencies\n#[allow(unused)]\nfn main() {}\n" > "$";
        touch -t "200001010100" "$";'

cargo build --workspace "$@"

grep -E '^path\s*=\s*"([^"]*)"' Cargo.toml |
    sed -E 's/.*"([^"]*)".*/\1/' |
    xargs -I'$' sh -xc 'rm -f "$";'

find . -name target -prune -o -type f
printf 'done\n'
